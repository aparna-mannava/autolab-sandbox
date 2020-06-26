terraform {
  backend "http" {}
}
module "auto_winsql_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwmssl0057"
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
  }
}

output "auto_winsql_1" {
  value = {
    "fqdn"  = "${module.auto_winsql_1.fqdn}",
    "alias" = "${module.auto_winsql_1.alias}",
    "ip"    = "${module.auto_winsql_1.ip}",
  }
}
