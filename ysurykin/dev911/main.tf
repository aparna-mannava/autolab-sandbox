terraform {
  backend "s3" {}
}

locals {
  product     = "pmx"
  environment = "feature_PXDVOP_24317"
  datacenter  = "ny2"
  db_env      = "ny2-autolab-db-ahv"
  cluster     = "ny5-aza-ntnx-19"
  domain      = "auto.saas-n.com"
  lob         = "PBS"
  facts       = {
    "bt_tier"          = "dev"
    "bt_env"           = "911"
    "bt_pg_version"    = "12"
  }
}

module "pmx_pgdb_9" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpgdb911"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-pgdb01"
  bt_infra_network     = local.db_env
  bt_infra_cluster     = local.cluster
  os_version           = "rhel7"
  cpus                 = 2
  memory               = 12000
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT PMX PG"
  datacenter           = local.datacenter
  external_facts       = local.facts
  lob                  = local.lob
  additional_disks     = {
    1 = "100",
    2 = "300",
    3 = "300",
  }
}

output "pmx_pgdb_1" {
  value = {
    "fqdn"  = module.pmx_pgdb_9.fqdn,
    "alias" = module.pmx_pgdb_9.alias,
    "ip"    = module.pmx_pgdb_9.ip,
  }
}
