terraform {
  backend "http" {}
}

locals {
  product        = "inf"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vwbfsdevn7"
  hostgroup      = "BT MSSQL 2016 Server"
  facts          = {
    "bt_product"      = "bfs"
    "bt_tier"         = "dev"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}


module "inf_windns_n7" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-db-ahv"
  lob                  = "inf"
  os_version           = "win2016"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "50",
    2 = "100",
    3 = "100",
    4 = "100",
    5 = "100",
    6 = "50"
  }
}

output "inf_windns_n7" {
  value = {
    "fqdn"  = "${module.inf_windns_n7.fqdn}",
    "alias" = "${module.inf_windns_n7.alias}",
    "ip"    = "${module.inf_windns_n7.ip}",
  }
}
