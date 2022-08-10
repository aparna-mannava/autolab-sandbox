terraform {
  backend "s3" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
      "bt_role"     = "apacheds"
    }
    devops1_apacheds_facts    = {
      "bt_env"      = "devops1"
      "bt_role"     = local.facts.bt_role
      "bt_customer" = local.facts.bt_customer
      "bt_product"  = local.facts.bt_product
      "bt_tier"     = local.facts.bt_tier
     
     }    
}
 
module "devops1_apacheds" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrdxz"
  alias                = "cfrmx-apacheds"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-azd-ntnx-10"
  cpus                 = "2"
  memory               = "8192"
  os_version           = "rhel7"
  external_facts       = local.devops1_apacheds_facts
  foreman_environment  = "feature_CFRMRD_8000"
  foreman_hostgroup    = "CFRMRD apacheds"
  lob                  = "CFRM"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
	2 = "100"
  }
}

output "devops1_apacheds" {
  value = {
    "fqdn"  = module.devops1_apacheds.fqdn,
    "alias" = module.devops1_apacheds.alias,
    "ip"    = module.devops1_apacheds.ip,
  }
} 
