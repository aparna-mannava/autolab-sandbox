terraform {
  backend "http" {}
}

locals {
  product        = "autolab"
  environment    = "nonprod"
  datacenter     = "ny2"
  hostname       = "us01vwmytstl0003"
  hostgroup      = "BT MSSQL 2016 Server"
  facts          = {
    "bt_tier"         = "dev"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}


module "mytest_wins_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-db"
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

output "mytest_wins_1" {
  value = {
    "fqdn"  = "${module.mytest_wins_1.fqdn}",
    "alias" = "${module.mytest_wins_1.alias}",
    "ip"    = "${module.mytest_wins_1.ip}",
  }
}
