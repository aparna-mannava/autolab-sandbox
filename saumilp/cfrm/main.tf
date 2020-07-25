terraform {
  backend "http" {}
}

locals {
  product     = "cfrm"
  environment = "feature_CLOUD_66442"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "sbx"
    "bt_env"  = "3"
    "bt_customer" = "dgbcs"
	"bt_product" = "cfrm"
	"bt_role" = "oradb"
  }
}

module "cfrm_dbserver_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfdemo33"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-tf33"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT CFRM SP Oracle Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "50",
    4 = "50",
	  5 = "50"
  }
}

output "cfrm_dbserver_1" {
  value = {
    "fqdn"  = "${module.cfrm_dbserver_1.fqdn}",
    "alias" = "${module.cfrm_dbserver_1.alias}",
    "ip"    = "${module.cfrm_dbserver_1.ip}",
  }
}
