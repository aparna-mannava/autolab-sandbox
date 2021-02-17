terraform {
  backend "http" {}
}

locals {
  product        = "inf"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vwtstprom1"
  hostgroup      = "BT MSSQL 2016 Server"
  facts          = {
    "bt_product"      = "bfs"
    "bt_tier"         = "dev"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}


module "inf_windns_TSTPROM" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "inf"
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
    5 = "50",
    6 = "50"
  }
}

output "inf_windns_TSTPROM" {
  value = {
    "fqdn"  = "${module.inf_windns_TSTPROM.fqdn}",
    "alias" = "${module.inf_windns_TSTPROM.alias}",
    "ip"    = "${module.inf_windns_TSTPROM.ip}",
  }
}