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
    devops1_opensearch_facts    = {
      "bt_env"      = "dynamic-scan"
      "bt_role"     = local.facts.bt_role
      "bt_customer" = local.facts.bt_customer
      "bt_product"  = local.facts.bt_product
      "bt_tier"     = local.facts.bt_tier
     
     }    
}
 
module "devops1_opensearch" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrdx153"
  alias                = "cfrmx-os-test1"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  cpus                 = "4"
  memory               = "16384"
  os_version           = "rhel8"
  external_facts       = local.devops1_opensearch_facts
  foreman_environment  = "feature_CFRMRD_43048"
  foreman_hostgroup    = "BT CFRMRD Opensearch"
  lob                  = "CFRM"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
	2 = "100"
  }
}

output "devops1_opensearch" {
  value = {
    "fqdn"  = module.devops1_opensearch.fqdn,
    "alias" = module.devops1_opensearch.alias,
    "ip"    = module.devops1_opensearch.ip,
  }
}