terraform {
  backend "s3" {}
}

locals {
  environment = "master"
  datacenter  = "ny2"
  facts         = {
    "bt_tier"             = "pr"
    "bt_env"              = "1"
    "bt_product"          = "inf"
    "bt_role"             = "base"
  }
}

module "inf_test_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlntnxtst1"
  alias                = "inf-auto-tst01"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
}


output "inf_test_1" {
  value = {
    "fqdn"  = module.inf_test_1.fqdn,
    "alias" = module.inf_test_1.alias,
    "ip"    = module.inf_test_1.ip,
  }
}
#Decommision-
