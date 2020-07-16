terraform {
  backend "http" {}
}

locals {
  product        = "autolab"
  environment    = "nonprod"
  datacenter     = "ny2"
  hostname       = "us01vwcldpx069"
  hostgroup      = "BT MSSQL 2016 Server"
  facts          = {
    "bt_tier"    = "dev"
    "bt_domain"  = "auto.saas-n.com"
    "bt_role"    = "mssql"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}


module "wind_server_msql02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny2-azd-ntnx-11"
  bt_infra_network     = "ny2-autolab-db-ahv"
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

output "wind_server_msql02" {
  value = {
    "fqdn"  = "${module.wind_server_msql02.fqdn}",
    "alias" = "${module.wind_server_msql02.alias}",
    "ip"    = "${module.wind_server_msql02.ip}",
  }
}
