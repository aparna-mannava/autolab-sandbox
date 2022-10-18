terraform {
  backend "s3" {}
}

locals {
  lob         = "CLOUD"
  product     = "dgb"
  environment = "master"
  datacenter  = "ny2"
  facts         = {
    "bt_tier"             = "demo" #ex: sbx, tst, td, demo
    "bt_env"              = "1" #ex: leave blank for first env, or non-zero-padded number
  }
}

module "cloud_sqlserver_4" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwdemodb01"
  alias                = "tf-sql-dm-db01"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "CLOUD"
  os_version           = "win2019"
  cpus                 = "4"
  memory               = "16384"
  external_facts       = local.facts
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT BI MSSQL 2019 Server"
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "100",
    4 = "100",
    5 = "50",
    6 = "50"
  }
}


output "cloud_sqlserver_4" {
  value = {
    "fqdn"  = "${module.cloud_sqlserver_4.fqdn}",
    "alias" = "${module.cloud_sqlserver_4.alias}",
    "ip"    = "${module.cloud_sqlserver_4.ip}",
  }
}
