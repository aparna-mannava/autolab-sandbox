terraform {
  backend "http" {}
}
module "mssql_winpm_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwmssl0097"
  bt_infra_environment = "ny2-autolab-app"
  os_version           = "win2016"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT MSSQL 2016 Server"
  datacenter           = "ny2"
  lob                  = "CLOUD"
  additional_disks     = {
    1 = "200",
    2 = "200"
  }
  external_facts       = {
    "bt_tier" = "dev"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}

output "mssql_winpm_1" {
  value = {
    "fqdn"  = "${module.mssql_winpm_1.fqdn}",
    "alias" = "${module.mssql_winpm_1.alias}",
    "ip"    = "${module.mssql_winpm_1.ip}",
  }
}
