terraform {
  backend "s3" {}
}

locals {
  product        = "pcmiq"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vwstnd01"
  hostgroup      = "BT MSSQL 2019 Server"
  facts          = {
    "bt_env"          = "1"
    "bt_product"      = "pcmiq"
    "bt_tier"         = "dev"
    "bt_role"         = "mssql"
  }
}

module "stanard_121970_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = "auto-sa-stnd-db01"
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

output "stanard_121970_3" {
  value = {
    "fqdn"  = "${module.stanard_121970_3.fqdn}",
    "alias" = "${module.stanard_121970_3.alias}",
    "ip"    = "${module.stanard_121970_3.ip}",
  }
}
