terraform {
  backend "s3" {}
}

locals {
  product        = "inf"
  #environment    = "feature_CLOUD_103491"
  datacenter     = "ny2"
  hostname       = "us01vwhsp20194"
  hostgroup      = "BT MSSQL 2019 Server"
  facts          = {
    "bt_env"          = "1"
    "bt_product"      = "pcmiq"
    "bt_tier"         = "auto"
    "bt_role"         = "mssql"
  }
}


module "auto_103175" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = "us-01-vw-sp194"
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


output "auto_103175" {
  value = {
    "fqdn"  = "${module.auto_103175.fqdn}",
    "alias" = "${module.auto_103175.alias}",
    "ip"    = "${module.auto_103175.ip}",
  }
}
