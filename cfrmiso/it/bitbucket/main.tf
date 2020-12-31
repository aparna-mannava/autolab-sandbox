terraform {
  backend "http" {}
}

locals {
  product     = "cfrmit"
  environment = "feature_CFRMISO_309_puppet_for_clean_rhel_ny2_cfrmrd_il02_cluster" #  Bitbucket
  hostname    = "us01"
  facts = {
    "bt_product" = "cfrmiso"
    "bt_customer" = "it"
    "bt_tier" = "prod"
    "bt_role" = "cfrm_it"
  }
  datacenter = {
    name = "ny2"
    id   = "il02"
  }
  cfbb001 = { ## Bitbucket server ##
    hostname  = "${local.hostname}vlcfbb01"
    alias     = "${local.hostname}vlbitbucket01"
    silo      = "autolab"
    hostgroup = "BT CFRM IT Bitbucket Server"

  }
  cfhp001 = { ## HAProxy server ##
    hostname  = "${local.hostname}vlcfhp01"
    alias     = "${local.hostname}vlhaproxy01"
    silo      = "autolab"
    hostgroup = "BT CFRM IT HAProxy Server"
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
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.cfbb001.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
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
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.cfhp001.hostgroup}"
  datacenter          = "${local.datacenter.name}"
    additional_disks     = {
    1 = "50", // disk1
  }
}


output "cfbb001" {
  value = {
    "fqdn"  = "${module.cfbb001.fqdn}",
    "alias" = "${module.cfbb001.alias}",
    "ip"    = "${module.cfbb001.ip}",
  }
}

output "cfhp001" {
  value = {
    "fqdn"  = "${module.cfhp001.fqdn}",
    "alias" = "${module.cfhp001.alias}",
    "ip"    = "${module.cfhp001.ip}",
  }
}
