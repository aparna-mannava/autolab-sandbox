terraform {
  backend "s3" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
      "bt_role"     = "standalone"
    }
    dynamic_scan_apacheds_facts    = {
      "bt_env"      = "dynamic-scan"
      "bt_role"     = local.facts.bt_role
      "bt_customer" = local.facts.bt_customer
      "bt_product"  = local.facts.bt_product
      "bt_tier"     = local.facts.bt_tier
     
     }    
}
 
module "dynamic_scan_apacheds" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrdx9"
  alias                = "cfrmx-oracledb8"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  cpus                 = "2"
  memory               = "8192"
  os_version           = "rhel7"
  external_facts       = local.dynamic_scan_apacheds_facts
  foreman_environment  = "feature_CFRMX_8541"
  foreman_hostgroup    = "CFRMRD OpenSearch"
  lob                  = "CFRM"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
	2 = "100"
  }
}

output "dynamic_scan_apacheds" {
  value = {
    "fqdn"  = module.dynamic_scan_apacheds.fqdn,
    "alias" = module.dynamic_scan_apacheds.alias,
    "ip"    = module.dynamic_scan_apacheds.ip,
  }
}

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
    "bt_role" = "app"
    "bt_customer" = local.facts.bt_customer
    "bt_product" = local.facts.bt_product
    "bt_tier" = local.facts.bt_tier
    "bt_env" = local.facts.bt_env
  }
  app_server_2_facts   = {
    "bt_role" = "standalone"
    "bt_customer" = local.facts.bt_customer
    "bt_product" = local.facts.bt_product
    "bt_tier" = local.facts.bt_tier
    "bt_env" = local.facts.bt_env
  }
}

module "app_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd099"
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_role}"
  bt_infra_network     = "ny2-dgb-development"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  cpus                 = 6
  memory               = 24000
  os_version           = "rhel7"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT CFRMRD BaseAppServer"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "100",
	2 = "100"
  }
}

module "app_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd0991"
  alias                = "cfrm-dynamic-scan-ic.saas-n.com"
  bt_infra_network     = "ny2-dgb-development"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  cpus                 = 6
  memory               = 24000
  os_version           = "rhel7"
  foreman_environment  = local.app_server_2_facts
  foreman_hostgroup    = "BT CFRMRD Opensearch Standalone"
  datacenter           = "ny2"
  external_facts       = local.facts
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

output "app_server_2" {
  value = {
    "fqdn"  = module.app_server_2.fqdn,
    "alias" = module.app_server_2.alias,
    "ip"    = module.app_server_2.ip,
  }
}