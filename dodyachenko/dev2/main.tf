terraform {
  backend "s3" {}
}
 
locals {
  lob         = "CFRM"
  product     = "cfrm"
  environment = "feature_CUT1_10807"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "sbx"
	"bt_product" = "cfrm"
	"bt_customer" = "dgbcs"
	"bt_server_mode" = "single"
	"bt_server_number" = "01"
	"bt_deployment_mode" = "none"
	"bt_ic_version" = "6.6"
	"bt_ic_tag" = "v0001"
	"bt_groovy_version" = "2.5.8"
    "bt_env"  = "2"
  }
}
 
module "app_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlapp08033"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-app01"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  lob                  = "CFRM"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT CFRM SP Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}
 
output "app_server_1" {
  value = {
    "fqdn"  = "${module.app_server_1.fqdn}",
    "alias" = "${module.app_server_1.alias}",
    "ip"    = "${module.app_server_1.ip}",
  }
}
 