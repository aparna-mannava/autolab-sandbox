terraform {
  backend "http" {}
}

locals {
  # product     = "cfrmiso"
  hostname    = "us01vlcoel"
  environment = "feature_CFRMGC_373_c_hoare_uat_saas_p_cfrm" 
  hostgroup   = "BT CFRM C.Hoare ELK Servers"
  facts = {
    "bt_tier" = "autolab"
    "bt_customer" = "chc"
    "bt_product" = "cfrmcloud"
	  "bt_role" = "elastic"
    "bt_artemis_version" = "2.6.0"
    "bt_es_version" = "5.6.2"
    "bt_apacheds_version" = "2.0.0_M24"
  } 
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }
}

module "chcelk01" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.hostname}01"
  alias               = "cfrm-cloud-chc-u-gb00-elk01"
  bt_infra_cluster    = "ny2-aza-ntnx-05"
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

output "chcelk01" {
  value = {
    "fqdn"  = "${module.chcelk01.fqdn}",
    "alias" = "${module.chcelk01.alias}",
    "ip"    = "${module.chcelk01.ip}",
  }
}