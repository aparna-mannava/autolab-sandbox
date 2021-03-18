terraform {
  backend "http" {}
}

locals {
  product     = "cloud"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "pr"
    "bt_env"  = "2"
    "bt_role" = "oradb"
    "bt_customer" = "cnbpr"
  }
}

module "oradb_dbserver_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldbcnbpr1"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT DGB Oradb Secondary Server"
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
    "ip"    = "${module.oradb_dbserver_1.ip}",
  }
}
