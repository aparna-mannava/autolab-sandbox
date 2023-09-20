terraform {
  backend "s3" {}
}

locals {
  lob           = "CLOUD"
  puppet_env    = "master"
  datacenter    = "ny2"
  domain        = "auto.saas-n.com"
  environment   = "master"
  facts         = {


    "bt_product"      = "cloud"
    "bt_role"         = "oradb"
    "bt_tier"         = "tst"
    "bt_env"              = "" ##ex: leave blank for first env, or non-zero-padded number
    "bt_product_version"  = "3.6"
    "bt_em_agent"         = "13.4.0.0"
  }

  db_alias               = "Oracle-test-server"
  db_bt_infra_network    = "ny2-autolab-app-ahv"
  db_bt_infra_cluster    = "ny5-azh-ntnx-26"
  db_foreman_hostgroup   = "BT DGB Generic Server" # BT DGB Generic Server,BT DGB Oradb Server
}
module "oradb_dbsrvr_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlodbhsp11"
  alias                = "${local.db_alias}-dbhsp1"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT DGB Generic Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

module "oradb_dbsrvr_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlodbhsp12"
  alias                = "${local.db_alias}-dbhsp2"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT DGB Generic Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

module "oradb_dbsrvr_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlodbhsp13"
  alias                = "${local.db_alias}-dbhsp3"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT DGB Generic Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

module "oradb_dbsrvr_4" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlodbhsp14"
  alias                = "${local.db_alias}-dbhsp4"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT DGB Generic Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

output "oradb_dbsrvr_1" {
  value = {
    "fqdn"  = module.oradb_dbsrvr_1.fqdn,
    "alias" = module.oradb_dbsrvr_1.alias,
    "ip"    = module.oradb_dbsrvr_1.ip
  }
}

output "oradb_dbsrvr_2" {
  value = {
    "fqdn"  = module.oradb_dbsrvr_2.fqdn,
    "alias" = module.oradb_dbsrvr_2.alias,
    "ip"    = module.oradb_dbsrvr_2.ip
  }
}

output "oradb_dbsrvr_3" {
  value = {
    "fqdn"  = module.oradb_dbsrvr_3.fqdn,
    "alias" = module.oradb_dbsrvr_3.alias,
    "ip"    = module.oradb_dbsrvr_3.ip
  }
}

output "oradb_dbsrvr_4" {
  value = {
    "fqdn"  = module.oradb_dbsrvr_4.fqdn,
    "alias" = module.oradb_dbsrvr_4.alias,
    "ip"    = module.oradb_dbsrvr_4.ip
  }
}
