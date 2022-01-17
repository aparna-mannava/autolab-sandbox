terraform {
  backend "s3" {}
}

locals {
  product        = "inf"
  environment    = "master"
  datacenter     = "ny2"
  hostname       = "us01vwsa2019"
  hostgroup      = "BT MSSQL 2019 Server"
  facts          = {
    "bt_env"          = "1"
    "bt_product"      = "inf"
    "bt_tier"         = "dev"
    "bt_role"         = "mssql"
  }
}

module "sql_103479" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "CLOUD"
  os_version           = "win2019"
  cpus                 = "4"
  memory               = "16384"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "50",
    4 = "50",
    5 = "50",
    6 = "50"
  }
}

output "sql_103479" {
  value = {
    "fqdn"  = "${module.sql_103479.fqdn}",
    "alias" = "${module.sql_103479.alias}",
    "ip"    = "${module.sql_103479.ip}",
  }
}
