terraform {
  backend "http" {}
}

locals {
  product     = "cfrmiso"
  environment = "CFRMSUP_1528_create_CFRMISO_namespace" # Change to nonprod after 2020-02-11 Puppet release
  hostname    = "us01vlcfdb"
  hostgroup   = "BT FML CFRM Oracle DB"
  facts = {
    "bt_tier" = "autolab"
    "bt_env"  = "4"
    "bt_customer" = "cfrmrd"
    "bt_product" = "cfrmrd"
	  "bt_role" = "oradb"
    "bt_cfrm_version" = "6.1_SP1"
  }
   datacenter = {
    name = "ny2"
    id   = "ny2"
  }
  cfdb001 = {
    hostname = "${local.hostname}01"
    silo     = "autolab"
  }
}

module "cfdb001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfdb001.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.cfdb001.silo}-${local.facts.bt_role}-${local.cfdb001.hostname}"
  bt_infra_cluster    = "ny2-aza-ntnx-07"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "4"
  memory              = "16192"
  lob                 = "cfrm"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "250",
	  2 = "250",
	  3 = "250",
	  4 = "250"
  }
}

output "cfdb001" {
  value = {
    "fqdn"  = "${module.cfdb001.fqdn}",
    "alias" = "${module.cfdb001.alias}",
    "ip"    = "${module.cfdb001.ip}",
  }
}