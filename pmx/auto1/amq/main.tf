terraform {
  backend "s3" {}
}

locals {
  product     = "pmx"
#  environment = "nonprod"
  environment = "feature_PXDVOP_15451"
  datacenter  = "ny2"
  facts       = {
    "bt_product"       = "pmx"
    "bt_tier"          = "auto"
    "bt_env"           = "1"
  }
}

module "pmx_ss_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpmxss99"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-ss01"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = 2
  memory               = 4096
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Streamsets Server"
  datacenter           = local.datacenter
  lob                 = "PBS"
  external_facts       = local.facts
  additional_disks     = {
    1 = "100",
    2 = "150",
    3 = "150",
  }
}

output "pmx_ss_1" {
  value = {
    "fqdn"  = "${module.pmx_ss_1.fqdn}",
    "alias" = "${module.pmx_ss_1.alias}",
    "ip"    = "${module.pmx_ss_1.ip}",
  }
}
