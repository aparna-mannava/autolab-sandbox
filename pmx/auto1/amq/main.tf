terraform {
  backend "s3" {}
}

locals {
  product     = "pmx"
#  environment = "nonprod"
  environment = "feature_PXDVOP_15007"
  datacenter  = "ny2"
  facts       = {
    "bt_tier"          = "auto"
    "bt_env"           = "1"
  }
}

module "pmx_amq_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpmxamq99"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-amq01"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = 2
  memory               = 4096
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT PMX ArtemisMQ"
  datacenter           = local.datacenter
  lob                 = "pmx"
  external_facts       = local.facts
  additional_disks     = {
    1 = "50"
  }
}

output "pmx_amq_1" {
  value = {
    "fqdn"  = "${module.pmx_amq_1.fqdn}",
    "alias" = "${module.pmx_amq_1.alias}",
    "ip"    = "${module.pmx_amq_1.ip}",
  }
}
