terraform {
  backend "http" {}
}

locals {
  product     = "cfrmiso"
  environment = "feature_CFRMGC_374_c_hoare_saas_p_uat_servers_instantiation" # Change to nonprod after 2020-02-11 Puppet release
  hostname    = "us01vlchcdb"
  hostgroup   = "BT CFRM CHC DB"
  facts = {
    "bt_tier" = "autolab"
    "bt_customer" = "cfrmiso"
    "bt_product" = "cfrmiso"
	  "bt_role" = "oradb"
    "bt_cfrm_version" = "5.9_SP4"
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
  memory              = "12288"
  lob                 = "cfrm"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "250", // disk1
	  2 = "250", // disk2
	  3 = "250", // disk3
	  4 = "250"  // disk4
  }
}

output "cfdb001" {
  value = {
    "fqdn"  = "${module.cfdb001.fqdn}",
    "alias" = "${module.cfdb001.alias}",
    "ip"    = "${module.cfdb001.ip}",
  }
}