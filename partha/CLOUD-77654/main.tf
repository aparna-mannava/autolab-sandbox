terraform {
  backend "s3" {}
}

locals {
  product        = "btiq"
  environment    = "feature_CLOUD_78001"
  datacenter     = "ny2"
  hostname       = "us01vwbidb02"
  hostgroup      = "BT BI MSSQL 2019 Server"
  facts          = {
    "bt_env"          = "1"
    "bt_product"      = "bi"
    "bt_tier"         = "dev"
    "bt_role"         = "mssql"
    "bt_bfs_timezone" = "Eastern Standard Time"
  }
}

module "btiq_db_77654" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "inf"
  os_version           = "win2019"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "60",
    3 = "50",
    4 = "50",
    5 = "50",
    6 = "50"
  }
}

output "btiq_db_77654" {
  value = {
    "fqdn"  = "${module.btiq_db_77654.fqdn}",
    "alias" = "${module.btiq_db_77654.alias}",
    "ip"    = "${module.btiq_db_77654.ip}",
  }
}
