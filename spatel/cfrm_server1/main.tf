terraform {
  backend "http" {}
}

locals {
  product     = "cfrm"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "pr"
    "bt_env"  = "1"
    "bt_customer" = "WPBBMT"
    "bt_deployment_mode" = "live"
    "bt_role" = "oradb"
  }
}

module "dgb_oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldbcfsr01"
  alias                = "${local.product}-tst-${local.facts.bt_customer}${local.facts.bt_env}"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  bt_infra_network     = "ny2-autolab-db-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT CFRM SP Oracle Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  lob                  = "CLOUD"
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200",
    4 = 200
  }
}

output "dgb_oradb_server_1" {
  value = {
    "fqdn"  = "${module.dgb_oradb_server_1.fqdn}",
    "ip"    = "${module.dgb_oradb_server_1.ip}",
  }
}
