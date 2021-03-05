terraform {
  backend "http" {}
}

locals {
  product        = "cfm"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vwtfssql19"
  hostgroup      = "BT BFS MSSQL 2019 Server"
  lob			 = "fda"
  facts          = {
    "bt_product"      = "cfm"
    "bt_tier"         = "dev"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}


module "cfm_tfs_server" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = "${local.lob}-${local.facts.bt_product}-${local.facts.bt_tier}-${local.hostname}"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "${local.lob}"
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

output "cfm_tfs_server" {
  value = {
    "fqdn"  = "${module.cfm_tfs_server.fqdn}",
    "alias" = "${module.cfm_tfs_server.alias}",
    "ip"    = "${module.cfm_tfs_server.ip}",
  }
}
