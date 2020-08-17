terraform {
  backend "http" {}
}

locals {
  facts       = {
    "lob"       = "cloud"
    "bt_tier"    = "dev"
    "bt_product" = "cagso"
    "bt_role" = "postgresql"
    "bt_env"    = "1"
  }
}

module "oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltestdb01"
  alias                = "${local.facts.bt_tier}${local.facts.bt_env}-db01"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = "feature/ora19cupgrade"
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT DGB Oradb Server"
  datacenter           = "ny2"
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
