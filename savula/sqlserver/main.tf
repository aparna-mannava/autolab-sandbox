terraform {
  backend "s3" {}
}

locals {
  product        = "cloud"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vwdemo01"
  hostgroup      = "BT MSSQL 2019 Server"
  facts          = {
    "bt_product"      = "cloud"
    "bt_tier"         = "autolab"
    "bt_role"         = "mssql"
  }
}

module "stanard_127391_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = "auto-sa-demo-db01"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "CLOUD"
  os_version           = "win2019"
  cpus                 = "4"
  memory               = "8192"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "60",
    2 = "30",
    3 = "40",
    4 = "40",
    5 = "20",
    6 = "20"
  }
}

output "stanard_127391_2" {
  value = {
    "fqdn"  = "${module.stanard_127391_2.fqdn}",
    "alias" = "${module.stanard_127391_2.alias}",
    "ip"    = "${module.stanard_127391_2.ip}",
  }
}
