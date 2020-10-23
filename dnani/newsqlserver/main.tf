terraform {
  backend "http" {}
}

locals {
  environment            = "master"
  lob                    = "BFS"
  datacenter             = "ny2"
  os_version             = "win2016"
  hostgroup              = "BT MSSQL 2016 Server"
  domain                 = "auto.saas-n.com"
  bt_infra_network       = "ny2-inf-nonprod-services"
  cpus                   = "4"
  memory                 = "16384"
  db1_hostname           = "us01vwndagtest01"
  db1_alias              = "bfs-dev-ndagdb01"
  db1_bt_infra_network   = "ny2-autolab-db-ahv"
  db1_bt_infra_cluster   = "ny2-aza-ntnx-13"
  db1_foreman_hostgroup  = "MSSQL 2016 Server"
external_facts       = {
  "bt_product"       = "bfs"
  "bt_tier"          = "dev"
  "bt_bfs_timezone"  = "Eastern Standard Time"
  }
}

module "us01vwndag01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.db1_hostname}"
  alias                = ""
  datacenter           = "${local.datacenter}"
  os_version           = "${local.os_version}"
  bt_infra_network     = "${local.db1_bt_infra_network}"
  bt_infra_cluster     = "${local.db1_bt_infra_cluster}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.db1_foreman_hostgroup}"
  
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100",
    4 = "100",
    5 = "100",
    6 = "100"
  }
}

output "us01vwndag01" {
  value = <<INFO
{
||function||hostname||host alias||IP||
|db etz server|${module.us01vwndag01.fqdn}|${module.us01vwndag01.alias[0]}|${module.us01vwndag01.ip}|
}
INFO
}
