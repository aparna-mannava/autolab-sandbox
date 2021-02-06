terraform {
  backend "http" {}
}
#  Build test server
locals {
 # product     = "cfrmit"
  environment = "master" 
  hostname    = "us01"
  facts = {
    "bt_product"     = "cfrmit"
    "bt_role"     = "demo"
    "bt_host_number" = "0005"
    "bt_tier"     = "autolab"
  }
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }

  #|## Demo server module configuration ########|#
  app005 = { 
    hostname    = "${local.hostname}VLDEMO${local.facts.bt_host_number}"
    alias       = "${local.hostname}VLDEMO${local.facts.bt_host_number}"
    silo        = "autolab"
    hostgroup   = "BT CFRM IT Demo Servers" 
}
}
module "app005" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.app005.hostname}"
  alias               = "${local.app005.alias}"
  ## saas-p NY2 on IL02 subnet
  #bt_infra_cluster    = "il02-aza-ntnx-01"
  #bt_infra_network    = "il02_hosted_corp_app"
  ## auto.saas-n
  bt_infra_cluster    = "il02-aza-ntnx-01"
  bt_infra_network    = "il02-hosted-cfrm-dmz"
  os_version          = "rhel7"
  cpus                = "4"
  memory              = "8096"
  lob                 = "CFRM"
  external_facts      = "${local.app005.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.app005.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks    = {
    1 = "160", // disk1 100gb 
  }
}

output "app005" {
  value = {
    "fqdn"  = "${module.app005.fqdn}",
    "alias" = "${module.app005.alias}",
    "ip"    = "${module.app005.ip}"
  }
}