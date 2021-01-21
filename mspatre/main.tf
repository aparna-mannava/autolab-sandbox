#
# Build the IR PostgreSQL Database server
#
terraform {
  backend "s3" {}
}

locals {
  product     = "ir"
  domain      = "saas-n.com"
  environment = "feature_IRCA_858"
  datacenter  = "ny2"
  facts       = {
    "bt_product"       = "ir"
    "bt_tier"          = "dev"
    "bt_env"           = "1"
    "bt_override_date" = "2020-20-01"
    "bt_pg_version"    = "12"
  }
}

module "pgdb_server_ir_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlirpgdb01"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-pgdb01"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-receivables-dev-qa"
  os_version           = "rhel7"
  cpus                 = 2
  memory               = 8192
  lob                  = "IR"
  foreman_hostgroup    = "BT IR PG"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "100",
    2 = "150",
    3 = "150"
  }
}

output "pgdb_server_ir_1" {
  value = {
    "fqdn"  = "${module.pgdb_server_ir_1.fqdn}",
    "alias" = "${module.pgdb_server_ir_1.alias}",
    "ip"    = "${module.pgdb_server_ir_1.ip}",
  }
}
