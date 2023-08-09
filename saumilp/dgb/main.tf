terraform {
  backend "s3" {}
}

locals {
  lob         = "dgb"
  product     = "dgb"
  environment = "master"
  datacenter  = "ny2"
  facts         = {
    "bt_customer"         = "fi1234" #ex: fiXXXX
    "bt_tier"             = "pr" #ex: sbx, tst, td, demo
    "bt_env"              = "1" #ex: leave blank for first env, or non-zero-padded number
    "bt_product"          = "dgb"
    "bt_product_version"  = "3.6"
  }
}

module "cloud_dbserver_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldbsdp37"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db37"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}


module "cloud_dbserver_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldbsdp38"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db38"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
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

output "cloud_dbserver_2" {
  value = {
    "fqdn"  = module.cloud_dbserver_2.fqdn,
    "alias" = module.cloud_dbserver_2.alias,
    "ip"    = module.cloud_dbserver_2.ip
  }
}