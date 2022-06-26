terraform {
  backend "s3" {}
}

locals {

    facts       = {
      bt_customer        = "ny2"
      bt_product         = "cfrmcloud"
      bt_lob             = "CFRM"
      bt_tier            = "dev"
      bt_env             = "01"
      bt_role            = "artemis"
      bt_artemis_version = "2.16.0" // Artemis service version
      bt_infra_network   = "ny2-autolab-app-ahv"
      bt_infra_cluster   = "ny2-aze-ntnx-12"
      hostgroup          = "BT CFRM CLOUD Artemis Standalone Servers" // Foreman hostgroup for Standalone Artemis only servers
      environment        = "bugfix_CFRMCLOUD_2327" // Bitbucket Puppet controlrepo branch name
      hostname           = "us01vlcfrm"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "artemisdev_ny2_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}art${local.facts.bt_env}" // us01vlcfrmart01
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-${local.facts.bt_env}"//   cfrmcloud-ny2-dev-artemis-01.autolab.saas-n.com
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  //firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.facts
  os_version           = "rhel7"
  cpus                 = "2"
  memory         	     = "2048"
  additional_disks     = {
    1 = "100"
  }
}

output "artemisdev_ny2_1" {
  value = {
    "fqdn"  = module.artemisdev_ny2_1.fqdn,
    "alias" = module.artemisdev_ny2_1.alias,
    "ip"    = module.artemisdev_ny2_1.ip,
  }
}