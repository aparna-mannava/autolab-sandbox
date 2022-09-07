terraform {
  backend "s3" {}
}
 
 
locals {
 
    facts       = {
      bt_customer        = "ny2"
      bt_product         = "cfrmcloud"
      bt_lob             = "CFRM"
      bt_ic_version      = "660_SP2"
      bt_tier            = "dev" //
      bt_env             = "03" //
      bt_role            = "artemis" //
      bt_artemis_version = "2.16.0" // Artemis service version
      bt_artemis_ha      = "MasterSlave"
      bt_infra_network   = "ny2-autolab-app-ahv" //
      bt_infra_cluster   = "ny2-aze-ntnx-12"
      hostgroup          = "BT CFRM CLOUD Artemis Cluster Servers" // Foreman hostgroup for Standalone Artemis only servers
      environment        = "feature_CFRMCLOUD_2369" // Bitbucket Puppet controlrepo branch name
      hostname           = "us01vlcfrm"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}
 
module "artemisdev_ny2_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}art03" // us01vlcfrmart03
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-03"//   cfrmcloud-ny2-dev-artemis-02.autolab.saas-n.com
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
  memory               = "2048"
  additional_disks     = {
    1 = "100"
  }
}

module "artemisdev_ny2_4" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}art04" // us01vlcfrmart04
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-04"//   cfrmcloud-ny2-dev-artemis-02.autolab.saas-n.com
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
  memory               = "2048"
  additional_disks     = {
    1 = "100"
  }
}

module "artemisdev_ny2_5" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}art05" // us01vlcfrmart05
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-${local.facts.bt_role}-05"//   cfrmcloud-ny2-dev-artemis-02.autolab.saas-n.com
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
  memory               = "2048"
  additional_disks     = {
    1 = "30"
  }
}
 
output "artemisdev_ny2_3" {
  value = {
    "fqdn"  = module.artemisdev_ny2_3.fqdn,
    "alias" = module.artemisdev_ny2_3.alias,
    "ip"    = module.artemisdev_ny2_3.ip,
  }
}

output "artemisdev_ny2_4" {
  value = {
    "fqdn"  = module.artemisdev_ny2_4.fqdn,
    "alias" = module.artemisdev_ny2_4.alias,
    "ip"    = module.artemisdev_ny2_4.ip,
  }
}

output "artemisdev_ny2_5" {
  value = {
    "fqdn"  = module.artemisdev_ny2_5.fqdn,
    "alias" = module.artemisdev_ny2_5.alias,
    "ip"    = module.artemisdev_ny2_5.ip,
  }
}