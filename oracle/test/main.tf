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
  hostname             = "us01vlcfrmrdx7"
  alias                = "cfrmx-oracledb6"
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
