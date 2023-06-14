terraform {
  backend "s3" {}
}

locals {
  facts       = {
    "bt_customer" = "cfrmrd"
    "bt_product" = "cfrmrd"
    "bt_role" = "standalone"  
    "bt_tier" = "dev"
    "bt_env" = "devops1"
  }
  app_server_1_facts   = {
    "bt_role" = local.facts.bt_role
    "bt_customer" = local.facts.bt_customer
    "bt_product" = local.facts.bt_product
    "bt_tier" = local.facts.bt_tier
    "bt_env" = local.facts.bt_env
  }
}

module "app_server_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd000"
  alias                = "cfrm-dynamic"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  cpus                 = 4
  memory               = 8000
  os_version           = "rhel8"
  foreman_environment  = "feature_CFRMRD_40239"
  foreman_hostgroup    = "BT CFRMRD apacheds standalone"
  datacenter           = "ny2"
  lob                  = "CFRM"
  external_facts       = local.app_server_1_facts
  additional_disks     = {
    1 = "100",
	2 = "100"
  }
}

output "app_server_1" {
  value = {
    "fqdn"  = module.app_server_1.fqdn,
    "alias" = module.app_server_1.alias,
    "ip"    = module.app_server_1.ip,
  }
}