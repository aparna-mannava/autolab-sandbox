terraform {
  backend "http" {}
}

locals {
  product     = "cagso"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "qa"
    "bt_env"  = "2"
    "bt_product" = "cagso"
  }
}

module "oflows_pg_poc_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldbpgo031"
  bt_infra_cluster     = "ny2-azd-ntnx-10"
  bt_infra_network     = "ny2-dgb-cagso-dev-imp-db"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "16384"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Postgresql DB Server"
  datacenter           = local.datacenter
  lob                  = "CLOUD"
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200",
    4 = "200",
    5 = "200"
  }
}

output "oflows_pg_poc_server_1" {
  value = {
    "fqdn"  = "${module.oflows_pg_poc_server_1.fqdn}",
    "ip"    = "${module.oflows_pg_poc_server_1.ip}",
  }
}


