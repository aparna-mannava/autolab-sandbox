terraform {
  backend "s3" {}
}

locals {

    facts       = {
      bt_customer        = "ny2"        // mandatory
      bt_product         = "cfrmcloud"  // mandatory
      bt_lob             = "CFRM"       // mandatory
      bt_tier            = "dev"        // mandatory
      bt_env             = "02"         // mandatory
      bt_role            = "base"       // mandatory
      bt_infra_network   = "ny2-autolab-app-ahv" //
      bt_infra_cluster   = "ny2-aze-ntnx-12"
      hostgroup          = "BT Base Server" // Foreman hostgroup for BT base servers in Autolab.saas-n domain
      environment        = "master" // Bitbucket Puppet controlrepo branch name
      hostname           = "us01vlcfrm"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "basedev_ny2_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}bs${local.facts.bt_env}" // us01vlcfrmbs01 , maximum of 15 characters
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-${local.facts.bt_env}"//   cfrmcloud-ny2-dev-base-01.autolab.saas-n.com
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
    1 = "20"
  }
}

output "basedev_ny2_1" {
  value = {
    "fqdn"  = module.basedev_ny2_1.fqdn,
    "alias" = module.basedev_ny2_1.alias,
    "ip"    = module.basedev_ny2_1.ip,
  }
}