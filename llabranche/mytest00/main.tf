terraform {
  backend "http" {}
}
module "mytest_wins_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwmytstl0003"
  bt_infra_environment = "ny2-autolab-app"
  os_version           = "win2016"
  foreman_environment  = "nonprod"
  foreman_hostgroup    = "BT MSSQL 2016 Server"
  datacenter           = "ny2"
  lob                  = "cloud"
  additional_disks     = {
    1 = "200",
    2 = "200"
  }
  external_facts       = {
    "bt_tier" = "dev"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}

output "mytest_wins_1" {
  value = {
    "fqdn"  = "${module.mytest_wins_1.fqdn}",
    "alias" = "${module.mytest_wins_1.alias}",
    "ip"    = "${module.mytest_wins_1.ip}",
  }
}
