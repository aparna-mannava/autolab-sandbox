terraform {
  backend "s3" {}
}

locals {
  product        = "cloud"
  environment    = "feature_CLOUD_120573"
  datacenter     = "ny2"
  hostname       = "us01vwdba01"
  hostgroup      = "BT MSSQL 2019 Server"
  facts          = {
    "bt_env"          = "1"
    "bt_product"      = "cloud"
    "bt_tier"         = "dev"
    "bt_role"         = "mssql"
  }
}


module "cloud_120573" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = "sql-2019-dba01"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "DGB"
  os_version           = "win2019"
  cpus                 = "4"
  memory               = "32768"
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

output "cloud_120573" {
  value = {
    "fqdn"  = "${module.cloud_120573.fqdn}",
    "alias" = "${module.cloud_120573.alias}",
    "ip"    = "${module.cloud_120573.ip}",
  }
}
