terraform {
  backend "http" {}
}

locals {
  product     = "dgb"
  environment = "feature/ora19cupgrade"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "2"
    "bt_customer" = "fi1001"
	"bt_product" = "cfrm"
	"bt_role" = "oradb"
  }
}

module "oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltestdev01"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-dev01"
  bt_infra_cluster     = "ny2-azd-ntnx-10"
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

output "oradb_server_1" {
  value = {
    "fqdn"  = "${module.oradb_server_1.fqdn}",
    "alias" = "${module.oradb_server_1.alias}",
    "ip"    = "${module.oradb_server_1.ip}",
  }
}
