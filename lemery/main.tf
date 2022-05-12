terraform {
  backend "s3" {}
}

locals {
  os              = "rhel7"
  domain          = "auto.saas-n.com"
  datacenter      = "ny2"
  tier            = "dev"
  bt_env          = "1"
  bt_product      = "cloud"
  lob             = "CLOUD"
  environment     = "master"
  cluster         = "ny2-azb-ntnx-09"
  network         = "ny5-kubernetes-azb-auto"
  facts           = {
    "bt_env"                  = "${local.bt_env}"
    "bt_tier"                 = "${local.tier}"
    "bt_product"              = "${local.bt_product}"
  }
}

module "rgw_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlrgw001"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = "BT Base Server"
  foreman_environment  = local.environment
  os_version           = local.os
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

output "rgw_0" {
  value = {
    "fqdn"  = "${module.rgw_0.fqdn}",
    "alias" = "${module.rgw_0.alias}",
    "ip"    = "${module.rgw_0.ip}",
  }
}

