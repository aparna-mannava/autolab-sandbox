terraform {
  backend "http" {}
}
#  Build test server
locals {
  product     = "cfrmit"
  environment = "feature_CFRMGC_219_puppet_test" #    Build Bitbucket and HAProxy
  hostname    = "us01"
  facts = {
    "bt_product"     = "cfrmiso"
    "bt_role"     = "elastic"
    "bt_host_number" = "001"
  }
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }
  #|#################################################|#  
  #|## -- create Bitbucket and HAProxy servers -- ###|#
  #|#################################################|#

  #|## Bitbucket server module configuration ########|#
  e001 = { 
    hostname    = "${local.hostname}vlbb${local.facts.bt_host_number}"
    alias       = "${local.hostname}vlbitbucket${local.facts.bt_host_number}"
    silo        = "autolab"
    hostgroup   = "BT CFRM Eitan Test" 
    facts       = {
      "bt_product"  = "${local.facts.bt_product}"
      "bt_role"     = "${local.facts.bt_role}"
      "bt_app"      = "bitbucket"}
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
  bt_infra_cluster    = "ny5-aza-ntnx-14"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "4"
  memory              = "8096"
  lob                 = "CFRM"
  external_facts      = "${local.e001.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.e001.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks    = {
    1 = "250", // disk1
  }
}

output "e001" {
  value = {
    "fqdn"  = "${module.e001.fqdn}",
    "alias" = "${module.e001.alias}",
    "ip"    = "${module.e001.ip}",
    "app"   = "${local.e001.facts.bt_app}"
  }
}