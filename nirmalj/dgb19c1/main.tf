terraform {
  backend "s3" {}
}

locals {
  lob         = "dgb"
  product     = "dgb"
  environment = "feature_CLOUD_103960"
  datacenter  = "ny2"
  facts         = {
    "bt_customer"         = "fi7890" #ex: fiXXXXX
    "bt_tier"             = "sbx" #ex: sbx, tst, td, demo
    "bt_env"              = "" #ex: leave blank for first env, or non-zero-padded number
    "bt_product"          = "dgb"
    "bt_product_version"  = "3.6"
    "bt_em_agent"         = "13.4.0.0"
  }
}

module "cloud_dbserver_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldgbsbx22"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db22"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "10240"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT DGB Oradb 19c Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "500",
    2 = "300",
    3 = "300",
    4 = "300"
  }
}


module "cloud_dbserver_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldgbsbx23"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db23"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "10240"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT DGB Oradb 19c Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "400",
    2 = "300",
    3 = "300"
  }
}



output "cloud_dbserver_1" {
  value = {
    "fqdn"  = module.cloud_dbserver_1.fqdn,
    "alias" = module.cloud_dbserver_1.alias,
    "ip"    = module.cloud_dbserver_1.ip
  }
}

output "cloud_dbserver_2" {
  value = {
    "fqdn"  = module.cloud_dbserver_2.fqdn,
    "alias" = module.cloud_dbserver_2.alias,
    "ip"    = module.cloud_dbserver_2.ip
  }
}
