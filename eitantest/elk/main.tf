terraform {
  backend "s3" {}
}
#  Build test server
locals {
 # product     = "cfrmcloud"
 # environment = "feature_CFRMGC_219_puppet_test" 
  environment = "feature_CFRMCLOUD_928_devops_puppet_add_additional_folders_to_be_created"
  hostname    = "us01"
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }

  #|## Elk server module configuration ########|#
  e001 = { 
    hostname    = "${local.hostname}vlelk001"
    alias       = "${local.hostname}vlelastic001"
    silo        = "autolab"
    hostgroup   = "BT CFRM Eitan Test" 
    facts       = {
      "bt_product"  = "cfrmcloud"
      "bt_role" = "elastic"
      "bt_tier" = "autolab"
      "bt_lob" = "cfrm"}
  }
}
module "e001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.e001.hostname}"
  alias               = "${local.e001.alias}"
  ## saas-p NY2 on IL02 subnet
  #bt_infra_cluster    = "il02-aza-ntnx-01"
  #bt_infra_network    = "il02_hosted_corp_app"
  ## auto.saas-n
  bt_infra_cluster    = "ny2-aze-ntnx-11"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "4"
  memory              = "4048"
  lob                 = "cfrm"
  external_facts      = "${local.e001.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.e001.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks    = {
    1 = "250", // disk1 100gb
  }
}

output "e001" {
  value = {
    "fqdn"  = "${module.e001.fqdn}",
    "alias" = "${module.e001.alias}",
    "ip"    = "${module.e001.ip}",
  }
}