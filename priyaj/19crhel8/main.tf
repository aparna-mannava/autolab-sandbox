terraform {
  backend "s3" {}
}

locals {
  environment = "master"
  lob         = "CLOUD"
  datacenter  = "ny2"
  facts         = {
    "bt_lob"              = "fml"
    "bt_tier"             = "tst"
    "bt_role"             = "oradb"
    "bt_env"              = "1" #ex: leave blank for first env, or non-zero-padded number
    "bt_product"          = "fmlsaas"
  }
}

module "cloud_dbserver_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlora19c8"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "300",
    2 = "200",
    3 = "200"
  }
}

output "cloud_dbserver_1" {
  value = {
    "fqdn"  = module.cloud_dbserver_1.fqdn,
    "alias" = module.cloud_dbserver_1.alias,
    "ip"    = module.cloud_dbserver_1.ip
  }
}
