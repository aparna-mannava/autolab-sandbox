terraform {
  backend "http" {}
}

locals {
  product        = "autolab"
  environment    = "nonprod"
  datacenter     = "ny2"
  hostname       = "us01vwcloud061"
  hostgroup      = "BT MSSQL 2016 Server"
  facts          = {
    "bt_tier"    = "dev"
    "bt_domain"  = "auto.saas-n.com"
    "bt_role"    = "mssql"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}


module "test_server_ssql2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny2-aze-ntnx-10"
  bt_infra_network     = "ny2-autolab-db-ahv"
  bt_role                  = "mssql"
  lob                  = "cloud"
  os_version           = "win2016"
  cpus                 = "2"
  memory               = "8092"
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

output "test_server_ssql2" {
  value = {
    "fqdn"  = "${module.test_server_ssql2.fqdn}",
    "alias" = "${module.test_server_ssql2.alias}",
    "ip"    = "${module.test_server_ssql2.ip}",
  }
}
