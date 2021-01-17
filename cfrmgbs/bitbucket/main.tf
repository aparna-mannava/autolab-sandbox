terraform {
  backend "http" {}
}

locals {
  product     = "cfrmgbs"
  environment = "feature_CFRMGC_192_change_in_puppet_repo_from_cfrmiso_to_cfrmgbs" #  Build Bitbucket and HAProxy
  hostname    = "us01"
  facts = {
    "bt_product"  = "cfrmgbs"
    "bt_customer" = "it"
    "bt_tier"     = "prod"
    "bt_role"     = "cfrm_it"
    "bt_host_number" = "003"
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
    hostgroup   = "BT CFRM GBS IT Bitbucket Server"
    facts       = {
      "bt_product"  = "${local.facts.bt_product}"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_tier"     = "${local.facts.bt_tier}"
      "bt_role"     = "${local.facts.bt_role}"
      "bt_app"      = "bitbucket" }
  }
  
  #|## HAProxy server module configuration ########|#
  cfhp001 = { 
     hostname    = "${local.hostname}vlprx${local.facts.bt_host_number}"
    alias       = "${local.hostname}vlhaproxy${local.facts.bt_host_number}"
    silo        = "autolab"
    hostgroup   = "BT CFRM GBS IT Bitbucket Server"
    facts       = {
      "bt_product"  = "${local.facts.bt_product}"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_tier"     = "${local.facts.bt_tier}"
      "bt_role"     = "${local.facts.bt_role}"
      "bt_app"      = "haproxy" }
  }
}
module "cfbb001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfbb001.hostname}" #us01vlcfbb01.auto.saas-n.com
  alias               = "${local.datacenter.id}-${local.cfbb001.alias}" #il02-us01vlbitbucket01 
  ## saas-p NY2
  #bt_infra_cluster    = "il02-aza-ntnx-01"
  #bt_infra_network    = "il02_hosted_corp_app"
  ## auto.saas-n
  bt_infra_cluster    = "ny5-aza-ntnx-14"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "4"
  memory              = "12288"
  lob                 = "CFRM"
  external_facts      = "${local.cfbb001.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.cfbb001.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks    = {
    1 = "250", // disk1
  }
}

module "cfhp001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfhp001.hostname}" #us01vlcfha01.auto.saas-n.com
  alias               = "${local.datacenter.id}-${local.cfhp001.alias}" #il02-us01vlhaproxy01.auto.saas-n.com
  ## saas-p NY2
  #bt_infra_cluster    = "il02-aza-ntnx-01"
  #bt_infra_network    = "il02_hosted_corp_app"
  ## auto.saas-n
  bt_infra_cluster    = "ny5-aza-ntnx-14"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "2048"
  lob                 = "CFRM"
  external_facts      = "${local.cfhp001.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.cfhp001.hostgroup}"
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

output "cfhp001" {
  value = {
    "fqdn"  = "${module.cfhp001.fqdn}",
    "alias" = "${module.cfhp001.alias}",
    "ip"    = "${module.cfhp001.ip}",
    "app"   = "${local.cfhp001.facts.bt_app}"
  }
}