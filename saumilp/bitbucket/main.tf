terraform {
  backend "http" {}
}

locals {
  product     = "cloud"
  environment = "feature_CLOUD_70684"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dr"
    "bt_env"  = "2"
    "bt_role" = "oradb"
    "bt_customer" = "CDB"
  }
}

module "oradb_dbserver_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlbitbkt32"
  alias                = "cea-bbt-al2-oradb32"
  bt_infra_cluster     = "ny2-azb-ntnx-09"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Bitbucket Oracle DB Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100",
    4 = "100"
  }
}

output "oradb_dbserver_1" {
  value = {
    "fqdn"  = "${module.oradb_dbserver_1.fqdn}",
    "alias" = "${module.oradb_dbserver_1.alias}",
    "ip"    = "${module.oradb_dbserver_1.ip}",
  }
}
