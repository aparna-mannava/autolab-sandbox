terraform {
  backend "s3" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_env" = "devops"
    } 
    os01facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = "standalone"
     }
    os02facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = "app"
     }
}

module "artemis_apacheds_opensearch_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd444"
  alias                = "cfrmrd-test1"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  os_version           = "rhel7"
  external_facts       = local.os01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_39527"
  foreman_hostgroup    = "CFRMRD OpenSearch"
  datacenter           = "ny2"
  cpus                 = "8"
  memory         	   = "24576"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
} 

module "opensearch_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd445"
  alias                = "cfrmrd-test2"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  os_version           = "rhel7"
  external_facts       = local.os02facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_39527"
  foreman_hostgroup    = "CFRMRD App"
  datacenter           = "ny2"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "100",
    2 = "100"
  } 
}

output "artemis_apacheds_opensearch_1" {
  value = {
    "fqdn"  = module.artemis_apacheds_opensearch_1.fqdn,
    "alias" = module.artemis_apacheds_opensearch_1.alias,
    "ip"    = module.artemis_apacheds_opensearch_1.ip,
  }
}

output "opensearch_2" {
  value = {
    "fqdn"  = module.opensearch_2.fqdn,
    "alias" = module.opensearch_2.alias,
    "ip"    = module.opensearch_2.ip,
  }
}