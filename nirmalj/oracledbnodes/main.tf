terraform {
  backend "s3" {}
}

locals {
  lob         = "dgb"
  product     = "dgb"
  environment = "master"
  datacenter  = "ny2"
  facts         = {
    "bt_customer"         = "fi9876"       #ex: fiXXXX
    "bt_tier"             = "ppd"          #ex: sbx, tst, td, demo
    "bt_env"              = "2"            #ex: leave blank for first env, or non-zero-padded number
    "bt_product"          = "dgb"
    "bt_product_version"  = "3.6"
    "bt_em_agent"         = "13.4.0.0"

  }
}

module "oradb_dbserver_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlodb098"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db98"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
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

module "oradb_dbserver_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlodb099"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db99"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
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

module "oradb_dbserver_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlodb100"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db10"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
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

module "oradb_dbserver_4" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlodb101"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db11"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
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

output "oradb_dbserver_1" {
  value = {
    "fqdn"  = module.oradb_dbserver_1.fqdn,
    "alias" = module.oradb_dbserver_1.alias,
    "ip"    = module.oradb_dbserver_1.ip
  }
}

output "oradb_dbserver_2" {
  value = {
    "fqdn"  = module.oradb_dbserver_2.fqdn,
    "alias" = module.oradb_dbserver_2.alias,
    "ip"    = module.oradb_dbserver_2.ip
  }
}

output "oradb_dbserver_3" {
  value = {
    "fqdn"  = module.oradb_dbserver_3.fqdn,
    "alias" = module.oradb_dbserver_3.alias,
    "ip"    = module.oradb_dbserver_3.ip
  }
}

output "oradb_dbserver_4" {
  value = {
    "fqdn"  = module.oradb_dbserver_4.fqdn,
    "alias" = module.oradb_dbserver_4.alias,
    "ip"    = module.oradb_dbserver_4.ip
  }
}
