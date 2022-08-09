terraform {
  backend "s3" {}
}

locals {
  product     = "cfrm"
  environment = "feature_CLOUD_109889"
  datacenter  = "ny2"
  facts       = {
    "bt_product"         = "cfrm"
    "bt_customer"        = "varo"
    "bt_tier"            = "sbx"
    "bt_env"             = "1"
    "bt_role"            = "oradb"
  }
}

module "cfrm_dbserver_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmsbx23"
  alias                = "${local.product}-${local.facts.bt_customer}-${local.facts.bt_tier}23"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT CFRM SP Oracle19c Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

output "cfrm_dbserver_1" {
  value = {
    "fqdn"  = module.cfrm_dbserver_1.fqdn,
    "alias" = module.cfrm_dbserver_1.alias,
    "ip"    = module.cfrm_dbserver_1.ip
  }
}
