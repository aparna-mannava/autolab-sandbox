terraform {
  backend "s3" {}
}

locals {
  lob         = "dgb"
  product     = "dgb"
  environment = "master"
  datacenter  = "ny2"
  facts         = {
    "bt_customer"         = "fi9090" #ex: fiXXXX
    "bt_tier"             = "sbx" #ex: sbx, tst, td, demo
    "bt_role"             = "oradb"
    "bt_env"              = "1" #ex: leave blank for first env, or non-zero-padded number
    "bt_product"          = "dgb"
    "bt_product_version"  = "3.6"
  }
  facts_2         = {
    "bt_customer"         = "fi9091" #ex: fiXXXX
    "bt_tier"             = "pr" #ex: sbx, tst, td, demo
    "bt_role"             = "oradb"
    "bt_env"              = "1" #ex: leave blank for first env, or non-zero-padded number
    "bt_product"          = "dgb"
    "bt_product_version"  = "3.6"
  }
  facts_3         = {
    "bt_customer"         = "fi9091" #ex: fiXXXX
    "bt_tier"             = "dr" #ex: sbx, tst, td, demo
    "bt_role"             = "oradb"
    "bt_env"              = "2" #ex: leave blank for first env, or non-zero-padded number
    "bt_product"          = "dgb"
    "bt_product_version"  = "3.6"
  }
}

module "cloud_dbserver_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlsbdb190"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-sb90"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"
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
  hostname             = "us01vlprdb191"
  alias                = "${local.lob}-${local.facts_2.bt_tier}${local.facts_2.bt_env}-${local.facts_2.bt_customer}-pr91"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts_2
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

module "cloud_dbserver_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldrdb191"
  alias                = "${local.lob}-${local.facts_3.bt_tier}${local.facts_3.bt_env}-${local.facts_3.bt_customer}-dr91"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts_3
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

output "cloud_dbserver_3" {
  value = {
    "fqdn"  = module.cloud_dbserver_3.fqdn,
    "alias" = module.cloud_dbserver_3.alias,
    "ip"    = module.cloud_dbserver_3.ip
  }
}