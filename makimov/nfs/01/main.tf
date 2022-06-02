terraform {
  backend "s3" {}
}

locals {

    facts       = {
      bt_customer      = "ny2"
      bt_product       = "cfrmcloud"
      bt_lob           = "CFRM"
      bt_tier          = "dev"
      bt_env           = "01"
      bt_role          = "mgmt"
      bt_infra_network = "ny2-autolab-app-ahv"
      bt_infra_cluster = "ny2-aze-ntnx-12"
      hostgroup        = "BT CFRM CLOUD MGMT Base"
      environment      = "master" //
      hostname         = "us01vlcfrmnfs"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "nfsdev_ny2_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}${local.facts.bt_env}" //    us01vlcfrmnfs01
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-${local.facts.bt_tier}-nfs${local.facts.bt_env}"//   cfrmcloud-ny2-dev-nfs01.autolab.saas-n.com
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
    1 = "350"
  }
}

output "nfsdev_ny2_1" {
  value = {
    "fqdn"  = module.nfsdev_ny2_1.fqdn,
    "alias" = module.nfsdev_ny2_1.alias,
    "ip"    = module.nfsdev_ny2_1.ip,
  }
}