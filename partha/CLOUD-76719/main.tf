terraform {
  backend "http" {}
}
locals {
  product        = "inf"
  environment    = "feature_CLOUD_75638"
  datacenter     = "ny2"
  hostname       = "us01vw20192"
  hostgroup      = "BT BFS MSSQL 2019 Server"
  facts          = {
    "bt_product"      = "bfs"
    "bt_tier"         = "dev"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}
module "inf_windns_hsp" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "INF"
  os_version           = "win2016"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "90",
    3 = "50",
    4 = "50",
    5 = "50",
    6 = "50"
  }
}
output "inf_windns_hsp" {
  value = {
    "fqdn"  = "${module.inf_windns_hsp.fqdn}",
    "alias" = "${module.inf_windns_hsp.alias}",
    "ip"    = "${module.inf_windns_hsp.ip}",
  }
}
