terraform {
  backend "http" {}
}

locals {
  product     = "cfrmit"
  environment = "feature_CFRMISO_309_puppet_for_clean_rhel_ny2_cfrmrd_il02_cluster" # 
  hostname    = "us01"
  hostgroup   = "BT CFRM IT HAProxy Server"
  facts = {
    "bt_tier" = "prod"
    "bt_customer" = "it"
    "bt_product" = "cfrmiso"
	  "bt_role" = "cfrm_it"
  }
  datacenter = {
    name = "ny2"
    id   = "il02"
  }
  cfit001 = {
    hostname = "${local.hostname}vlcfit01"
    alias    = "${local.hostname}vl-haproxy01"
    silo     = "autolab"
  }
}

module "cfit001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfit001.hostname}" #us01vlcfit01.auto.saas-n.com
  alias               = "${local.datacenter.id}-${local.datacenter.name}-${local.cfit001.alias}-${local.cfit001.silo}" #il02-ny2-vl-haproxy01-autolab
  ## saas-p NY2
  #bt_infra_cluster    = "il02-aza-ntnx-01"
  #bt_infra_network    = "il02_hosted_corp_app"
  ## auto.saas-n
  bt_infra_cluster    = "ny2-aza-ntnx-13"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "2048"
  lob                 = "CFRM"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
}

output "cfit001" {
  value = {
    "fqdn"  = "${module.cfit001.fqdn}",
    "alias" = "${module.cfit001.alias}",
    "ip"    = "${module.cfit001.ip}",
  }
}
