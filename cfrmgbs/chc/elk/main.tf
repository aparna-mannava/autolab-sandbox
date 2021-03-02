terraform {
  backend "http" {}
}

locals {
  product     = "cfrmiso"
  environment = "feature_CFRMGC_374_c_hoare_saas_p_uat_servers_instantiation"    
  hostname    = "us01vlchc"
  hostgroup   = "BT CFRM ELK CHC "
  facts = {
    "bt_tier" = "autolab"
    "bt_customer" = "chc"
    "bt_product" = "cfrmiso"
	  "bt_role" = "elastic"
    "bt_artemis_version" = "2.6.0"
    "bt_es_version" = "5.6.2"
    "bt_apacheds_version" = "2.0.0_M24"
  } 
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }
  chcel01 = {
    hostname = "${local.hostname}el01"
    silo     = "autolab"
  }
}

module "chcel01" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.chcel01.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.chcel01.silo}-${local.facts.bt_role}-${local.chcel01.hostname}"
  bt_infra_cluster    = "ny2-azb-ntnx-08"
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
    1 = "50",  //   disk 1
  }
}

output "chcel01" {
  value = {
    "fqdn"  = "${module.chcel01.fqdn}",
    "alias" = "${module.chcel01.alias}",
    "ip"    = "${module.chcel01.ip}",
  }
}