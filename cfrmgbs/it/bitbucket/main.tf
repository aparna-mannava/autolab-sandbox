terraform {
  backend "http" {}
}
#  Build Bitbucket and HAProxy #
locals {
  product     = "cfrmit"
  environment = "feature_CFRMISO_309_puppet_for_clean_rhel_ny2_cfrmrd_il02_cluster" #     Build Bitbucket and HAProxy
  hostname    = "us01"
  facts = {
    "bt_product"     = "cfrmit"
    "bt_customer"    = "it"
    "bt_tier"        = "prod"
    "bt_role_bb"        = "bitbucket"
    "bt_role_ha"        = "haproxy"
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
  cfbb001 = { 
    hostname    = "${local.hostname}vlbb${local.facts.bt_host_number}"
    alias       = "${local.hostname}vlbitbucket${local.facts.bt_host_number}"
    silo        = "autolab"
    hostgroup   = "BT CFRM IT Bitbucket Server" 
    facts       = {
      "bt_product"  = "${local.facts.bt_product}"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_tier"     = "${local.facts.bt_tier}"
      "bt_role"     = "${local.facts.bt_role_bb}"
      "bt_app"      = "bitbucket"
      "bt_fw_group" = "CFRMRD_NY02_BH_TO_CFRMRD_PR_BB" }
  }
  
  #|## HAProxy server module configuration ########|#
  cfpx001 = { 
    hostname    = "${local.hostname}vlprx${local.facts.bt_host_number}"
    alias       = "${local.hostname}vlhaproxy${local.facts.bt_host_number}"
    silo        = "autolab"
    hostgroup   = "BT CFRM IT HAProxy Server"
    facts       = {
      "bt_product"  = "${local.facts.bt_product}"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_tier"     = "${local.facts.bt_tier}"
      "bt_role"     = "${local.facts.bt_role_ha}"
      "bt_app"      = "haproxy"
      "bt_fw_group" = "CFRMRD_NY02_BH_TO_CFRMRD_PR_HA" }
  }
}
module "cfbb001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfbb001.hostname}"
  alias               = "${local.cfbb001.alias}"
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
  external_facts      = "${local.cfbb001.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.cfbb001.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks    = {
    1 = "250", // disk1
  }
}

module "cfpx001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfpx001.hostname}" 
  alias               = "${local.cfpx001.alias}" 
  ## saas-p NY2 on IL02 subnet
  #bt_infra_cluster    = "il02-aza-ntnx-01"
  #bt_infra_network    = "il02_hosted_corp_app"
  ## auto.saas-n
  bt_infra_cluster    = "ny5-aza-ntnx-14"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "2048"
  lob                 = "CFRM"
  external_facts      = "${local.cfpx001.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.cfpx001.hostgroup}"
  datacenter          = "${local.datacenter.name}"
    additional_disks  = {
    1 = "50", // disk1
  }
}


output "cfbb001" {
  value = {
    "fqdn"  = "${module.cfbb001.fqdn}",
    "alias" = "${module.cfbb001.alias}",
    "ip"    = "${module.cfbb001.ip}",
    "app"   = "${local.cfbb001.facts.bt_app}"
  }
}

output "cfpx001" {
  value = {
    "fqdn"  = "${module.cfpx001.fqdn}",
    "alias" = "${module.cfpx001.alias}",
    "ip"    = "${module.cfpx001.ip}",
    "app"   = "${local.cfpx001.facts.bt_app}"
  }
}