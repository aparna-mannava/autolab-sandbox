terraform {
  backend "http" {}
}

locals {
  product        = "mssql"
  environment    = "nonprod"
  datacenter     = "ny2"
  hostname       = "us01vwmsql0093"
  hostgroup      = "BT MSSQL 2016 Server"
  facts          = {
    "bt_tier"         = "dev"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}


module "mssql_winpr_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-db"
  lob                  = "bfs"
  os_version           = "win2016"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "100"
  }
}

output "mssql_winpr_1" {
  value = {
    "fqdn"  = "${module.mssql_winpr_1.fqdn}",
    "alias" = "${module.mssql_winpr_1.alias}",
    "ip"    = "${module.mssql_winpr_1.ip}",
  }
}
