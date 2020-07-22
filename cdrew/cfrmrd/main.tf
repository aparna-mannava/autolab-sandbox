terraform {
  backend "http" {}
}

locals {
  product     = "cfrmrd"
  environment = "feature_CEA_8213_cfrm"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "2"
    "bt_customer" = "cfrmrd"
	  "bt_product" = "cfrmrd"
	  "bt_role" = "oradb"
  }
}

module "cfrm_dbserver_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrdtst"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-db81"
  bt_infra_cluster     = "ny2-azd-ntnx-10"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "cfrmrd"
  foreman_hostgroup    = "CFRMRD Oracle Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200",
  }
}

output "cfrmrd_dbserver_1" {
  value = {
    "fqdn"  = "${module.cfrm_dbserver_1.fqdn}",
    "alias" = "${module.cfrm_dbserver_1.alias}",
    "ip"    = "${module.cfrm_dbserver_1.ip}",
  }
}
