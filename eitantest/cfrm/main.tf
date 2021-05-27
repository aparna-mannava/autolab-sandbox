terraform {
  backend "s3" {}
}
#  Build test server
locals {
 # product     = "cfrmcloud"
 # environment = "feature_CFRMGC_219_puppet_test" 
 # environment = "feature_CFRMCLOUD_928_devops_puppet_add_additional_folders_to_be_created"
  environment = "feature_CFRMCLOUD_131_cfrm_install_standalone"
  hostname    = "us01"
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }

  #|## App server module configuration ########|#
  cfrm001 = {
    hostname    = "${local.hostname}vlcfrm001"
    alias       = "${local.hostname}vlbasecfrm001"
    silo        = "autolab"
    hostgroup   = "BT CFRM Eitan Test"
    facts       = {
      "bt_product"  = "cfrmcloud"
      "bt_role" = "cfrm"
      "bt_tier" = "autolab"
      "bt_lob" = "cfrm"}
  }
}
module "cfrm001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "local.cfrm001.hostname"
  alias               = "local.cfrm001.alias"
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
  external_facts      = local.cfrm001.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.app001.hostgroup
  datacenter          = local.datacenter.name
  additional_disks    = {
    1 = "100", // disk1 100gb
  }
}

output "cfrm001" {
  value = {
    "fqdn"  = "module.cfrm001.fqdn",
    "alias" = "module.cfrm001.alias",
    "ip"    = "module.cfrm001.ip",
  }
}