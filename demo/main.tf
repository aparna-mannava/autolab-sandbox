terraform {
  backend "s3" {}
}


locals {
  product        = "inf"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vlntnxtst1"
  hostgroup      = "BT Base Server"
  facts          = {
    "bt_product" = "inf"
    "bt_tier"    = "auto"
  }
}
 

module "inf_test_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = "inf-auto-tst01"
  bt_infra_environment = "ny2-autolab-app"
  lob                  = "inf"
  os_version           = "rhel6"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
}

 
output "inf_test_1" {
  value = {
    "fqdn"  = "${module.inf_test_1.fqdn}",
    "alias" = "${module.inf_test_1.alias}",
    "ip"    = "${module.inf_test_1.ip}",
  }
}
