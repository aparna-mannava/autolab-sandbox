terraform {
  backend "s3" {}
}

locals {
  product        = "cloud"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vwstskola1"
  hostgroup      = "BT MSSQL 2019 Server"
  facts          = {
    "bt_env"          = "1"
    "bt_product"      = "cloud"
    "bt_tier"         = "dev"
    "bt_role"         = "mssql"
  }
}


module "stanard_120354" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = "stanard-sk-tst-ag-db01"
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
    1 = "200",
    2 = "200",
    3 = "200",
    4 = "200",
    5 = "200",
    6 = "200"
  }
}

output "stanard_120354" {
  value = {
    "fqdn"  = "${module.stanard_120354.fqdn}",
    "alias" = "${module.stanard_120354.alias}",
    "ip"    = "${module.stanard_120354.ip}",
  }
}