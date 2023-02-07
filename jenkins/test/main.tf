terraform {
  backend "s3" {}
}

locals {
  facts       = {
    "bt_customer" = "cfrmrd"
    "bt_product" = "cfrmrd"
    "bt_role" = "standalone"  
    "bt_tier" = "dev"
    "bt_env" = "dynamic-scan"
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
  hostname             = "us01vlcfrmrd110"
  alias                = "dynamic-scan-standalones"
  bt_infra_network     = "ny2-dgb-development"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  cpus                 = 6
  memory               = 24000
  os_version           = "rhel7"
  foreman_environment  = "feature_CFRMRD_37888"
  foreman_hostgroup    = "CFRMRD OpenSearch"
  datacenter           = "ny2"
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