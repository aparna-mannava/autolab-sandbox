terraform {
  backend "s3" {}
}

locals {
  product        = "cloud"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vwdevp01"
  hostgroup      = "BT MSSQL 2019 Server"
  facts          = {
    "bt_env"          = "1"
    "bt_product"      = "cloud"
    "bt_tier"         = "dev"
    "bt_role"         = "mssql"
  }
}

module "devlpr_122226_5" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = "auto-sa-devlpr-db01"
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
    1 = "50",
    2 = "30",
    3 = "40",
    4 = "40",
    5 = "20",
    6 = "20"
  }
}

output "devlpr_122226_5" {
  value = {
    "fqdn"  = "${module.devlpr_122226_5.fqdn}",
    "alias" = "${module.devlpr_122226_5.alias}",
    "ip"    = "${module.devlpr_122226_5.ip}",
  }
}
