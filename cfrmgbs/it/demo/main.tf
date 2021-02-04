terraform {
  backend "http" {}
}

locals {
  product     = "cfrmit"
  environment = "feature_CFRMISO_309_puppet_for_clean_rhel_ny2_cfrmrd_il02_cluster" #   Build Bitbucket and HAProxy
  hostname    = "us01"
  facts = {
    "bt_product"  = "cfrmit"
    "bt_customer" = "it"
    "bt_tier"     = "prod"
    "bt_role"     = "demo"
  }
  datacenter = { 
    name = "ny2"
    id   = "il02"
  }
  #|#################################################|#  
  #|## -- create Demo Servers -- ###|#
  #|#################################################|#

  #|## Demo server 0001 module configuration ########| #
  app0001 = { 
    hostname    = "${local.hostname}vlDEMO0001"
    alias       = "${local.hostname}vlDEMO0001-CFRM"
    silo        = "autolab"
    hostgroup   = "BT CFRM IT DEMO Servers"
    facts       = {
      "bt_product"  = "${local.facts.bt_product}"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_tier"     = "${local.facts.bt_tier}"
      "bt_role"     = "${local.facts.bt_role}"
      } 
  }
  
  #|## Demo server 0002 module configuration ########|#
  app0002 = { 
    hostname    = "${local.hostname}vlDEMO0002"
    alias       = "${local.hostname}vlDEMO0002-CFRM"
    silo        = "autolab"
    hostgroup   = "BT CFRM IT DEMO Servers"
    facts       = {
      "bt_product"  = "${local.facts.bt_product}"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_tier"     = "${local.facts.bt_tier}"
      "bt_role"     = "${local.facts.bt_role}"
       }
  }
}
module "app0001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.app0001.hostname}" #us01vlcfbb01.auto.saas-n.com
  alias               = "${local.datacenter.id}-${local.app0001.alias}" #il02-us01vlbitbucket01 
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
  external_facts      = "${local.app0001.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.app0001.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks    = {
    1 = "250", // disk1
  }
}

module "app0002" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.app0002.hostname}" #us01vlcfha01.auto.saas-n.com
  alias               = "${local.datacenter.id}-${local.app0002.alias}" #il02-us01vlhaproxy01.auto.saas-n.com
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
  external_facts      = "${local.app0002.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.app0002.hostgroup}"
  datacenter          = "${local.datacenter.name}"
    additional_disks  = {
    1 = "50", // disk1
  }
}


output "app0001" {
  value = {
    "fqdn"  = "${module.app0001.fqdn}",
    "alias" = "${module.app0001.alias}",
    "ip"    = "${module.app0001.ip}",
  }
}

output "app0002" {
  value = {
    "fqdn"  = "${module.app0002.fqdn}",
    "alias" = "${module.app0002.alias}",
    "ip"    = "${module.app0002.ip}",
  }
}