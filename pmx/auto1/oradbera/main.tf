terraform {
  backend "s3" {}
}

locals {
  product     = "pmx"
#  environment = "master"
  environment = "feature_PXDVOP_15301"
  datacenter  = "ny2"
  facts       = {
    "bt_tier"          = "auto"
    "bt_env"           = "1"
    "bt_pmxdbtype"     = "1"
  }
}

module "pmx_odbera_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpmxdbe99"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-odbe01"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = 2
  memory               = 4096
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT PMX ORA DB ERA"
  datacenter           = local.datacenter
  lob                 = "PBS"
  external_facts       = local.facts
  additional_disks     = {
    1                  = "300"
    2                  = "125"
    3                  = "125"
  }
}

output "pmx_odbera_1" {
  value = {
    "fqdn"  = module.pmx_odbera_1.fqdn,
    "alias" = module.pmx_odbera_1.alias,
    "ip"    = module.pmx_odbera_1.ip,
  }
}
