terraform {
  backend "s3" {}
}

locals {
  product     = "pmx"
#  environment = "master"
  environment = "feature_PXDVOP_17228"
  datacenter  = "ny2"
  facts       = {
    "bt_tier"          = "auto"
    "bt_env"           = "1"
  }
}

module "pmx_pgdb_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpmxpg99"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-pg01"
  bt_infra_cluster     = "ny2-azb-ntnx-09"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = 4
  memory               = 24576
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT PMX PG"
  datacenter           = local.datacenter
  lob                 = "PBS"
  external_facts       = local.facts
  additional_disks     = {
  1 = "100",
  2 = "300",
  3 = "300",
  4 = "300",
  }
}

output "pmx_pgdb_1" {
  value = {
    "fqdn"  = module.pmx_pgdb_1.fqdn,
    "alias" = module.pmx_pgdb_1.alias,
    "ip"    = module.pmx_pgdb_1.ip,
  }
}
