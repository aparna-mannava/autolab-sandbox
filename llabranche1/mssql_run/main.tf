terraform {
  backend "http" {}
}

locals {
  product        = "mssql"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vwmonljl07"
  hostgroup      = "BT MSSQL 2016 Server"
  facts          = {
    "bt_product"      = "mssql"
    "bt_tier"         = "dev"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}


module "sql_windmn_03" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-db-ahv"
  lob                  = "cloud"
  os_version           = "win2016"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100",
    4 = "100",
    5 = "100",
    6 = "100"
  }
}

output "sql_windmn_03" {
  value = {
    "fqdn"  = "${module.sql_windmn_03.fqdn}",
    "alias" = "${module.sql_windmn_03.alias}",
    "ip"    = "${module.sql_windmn_03.ip}",
  }
}
