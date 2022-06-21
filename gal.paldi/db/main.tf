terraform {
  backend "s3" {}
}

locals {
  lob         = "CFRM"
  product     = "cfrm"
  environment = "feature_CUT2_10610_pluggable_db"
  datacenter  = "ny2"
  facts       = {
    "bt_product" = "cfrm"
    "bt_customer" = "bfs"
    "bt_tier" = "ppd"
    "bt_env"  = ""
    "bt_server_mode" = "db"
    "bt_deployment_mode" = "live"
    "bt_alias" = "cfrm-bfs-gal-db-live"
  }
}

module "oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlgal0810"
  alias                = local.facts.bt_alias
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = local.cluster
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "32000"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT CFRM SP Oracle19c Pluggable Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

output "oradb_server_1" {
  value = {
    "fqdn"  = "${module.oradb_server_1.fqdn}",
    "alias" = "${module.oradb_server_1.alias}",
    "ip"    = "${module.oradb_server_1.ip}",
  }
}
