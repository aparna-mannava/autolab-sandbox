terraform {
  backend "s3" {}
}

locals {
  product     = "cfrmiso"
  environment = "feature_CFRMGC_373_c_hoare_uat_saas_p_cfrm"
  hostname    = "us01vlcodb"
  hostgroup   = "BT CFRM C.Hoare DB Servers"
  facts = {
    "bt_tier" = "autolab"
    "bt_customer" = "chc"
    "bt_product" = "cfrmcloud"
	  "bt_role" = "oradb"
    "bt_cfrm_version" = "5.9_SP4"
  }
   datacenter = {
    name = "ny2"
    id   = "ny2"
  }
  chcdb01 = {
    hostname = "${local.hostname}01"
    silo     = "autolab"
  }
}

module "chcdb01" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.hostname}01"
  alias               = "cfrm-cloud-chc-u-gb00-db01"
  bt_infra_cluster    = "ny2-aze-ntnx-11"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "8"
  memory              = "12288"
  lob                 = "cfrm"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  # additional_disks     = {
  #   1 = "250", // disk1
	#   2 = "250", // disk2
	#   3 = "250", // disk3
	#   4 = "250"  // disk4
  # }
  additional_disks     = {
    1 = "200",  //   disk 1
  }
}

output "chcdb01" {
  value = {
    "fqdn"  = "${module.chcdb01.fqdn}",
    "alias" = "${module.chcdb01.alias}",
    "ip"    = "${module.chcdb01.ip}",
  }
}