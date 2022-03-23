terraform {
  backend "s3" {}
}

locals {
  lob         = "dgb"
  product     = "dgb"
  environment = "master"
  datacenter  = "ny2"
  facts         = {
    "bt_customer"         = "fi7777" #ex: fiXXXXXX
    "bt_tier"             = "pr" #ex: sbx, tst, td, demo
    "bt_env"              = "1" #ex: leave blank for first env, or non-zero-padded number
    "bt_product"          = "dgb"
    "bt_product_version"  = "3.6"
    "bt_em_agent"         = "13.4.0.0"
  }
}

module "cloud_dbserver_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlautolb77"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-lb77"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "6"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT DGB Oradb Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "300",
    2 = "200",
    3 = "200"
  }
}


output "cloud_dbserver_1" {
  value = {
    "fqdn"  = module.cloud_dbserver_1.fqdn,
    "alias" = module.cloud_dbserver_1.alias,
    "ip"    = module.cloud_dbserver_1.ip
  }
}
