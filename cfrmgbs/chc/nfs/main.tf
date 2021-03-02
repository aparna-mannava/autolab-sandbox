terraform {
  backend "http" {}
}

locals {
  product     = "cfrmiso"
  environment = "feature_CFRMGC_374_c_hoare_saas_p_uat_servers_instantiation"
  hostname    = "us01vlchc"
  hostgroup   = "BT CFRM NFS SERVER CHC"
    facts = {
    "bt_tier" = "autolab"
    "bt_customer" = "chc"
    "bt_product" = "cfrmiso"
	  "bt_role" = "mgmt"
  }
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }
  
  chcnfs001 = {
    hostname = "${local.hostname}mg001"
    silo     = "autolab"
  }
}

module "chcnfs001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.chcnfs001.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.chcnfs001.silo}-${local.facts.bt_role}-${local.chcnfs001.hostname}"
  bt_infra_cluster    = "ny2-aza-ntnx-05"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "4096"
  lob                 = "cfrm"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "50"
  }
}

output "chcnfs001" {
  value = {
    "fqdn"  = "${module.chcnfs001.fqdn}",
    "alias" = "${module.chcnfs001.alias}",
    "ip"    = "${module.chcnfs001.ip}",
  }
}