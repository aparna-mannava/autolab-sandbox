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

  #|## App server module configuration ########|#
  app001 = {
    hostname    = "${local.hostname}vlapp001"
    alias       = "${local.hostname}vlbaseapp001"
    silo        = "autolab"
    hostgroup   = "BT CFRM Eitan Test"
    facts       = {
      "bt_product"  = "cfrmcloud"
      "bt_role" = "app"
      "bt_tier" = "autolab"
      "bt_lob" = "cfrm"}
  }
}
module "app001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.app001.hostname}"
  alias               = "${local.app001.alias}"
  ## saas-p NY2 on IL02 subnet
  #bt_infra_cluster    = "il02-aza-ntnx-01"
  #bt_infra_network    = "il02_hosted_corp_app"
  ## auto.saas-n
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "2024"
  lob                 = "cfrm"
  external_facts      = "${local.app001.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.app001.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks    = {
    1 = "100", // disk1 100gb
  }
}

output "app001" {
  value = {
    "fqdn"  = "${module.app001.fqdn}",
    "alias" = "${module.app001.alias}",
    "ip"    = "${module.app001.ip}",
  }
}