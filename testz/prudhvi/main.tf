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
    es01facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = "standalone"
     }
    es02facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = "opensearch"
     }
    es03facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = "opensearch"
    }
} 

module "elasticsearch_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd009"
  alias                = "cfrmx-standalone"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  os_version           = "rhel7"
  external_facts       = local.es01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_39527"
  foreman_hostgroup    = "BT CFRMRD Opensearch Artemis"
  datacenter           = "ny2"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
} 

module "elasticsearch_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd010"
  alias                = "cfrmx-opensearch1"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  os_version           = "rhel7"
  external_facts       = local.es02facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_39527"
  foreman_hostgroup    = "BT CFRMRD Opensearch Alone"
  datacenter           = "ny2"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
}

module "elasticsearch_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd011"
  alias                = "cfrmx-opensearch2"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  os_version           = "rhel7"
  external_facts       = local.es03facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_39527"
  foreman_hostgroup    = "BT CFRMRD Opensearch Alone"
  datacenter           = "ny2"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
} 

output "elasticsearch_1" {
  value = {
    "fqdn"  = module.elasticsearch_1.fqdn,
    "alias" = module.elasticsearch_1.alias,
    "ip"    = module.elasticsearch_1.ip,
  }
}

output "elasticsearch_2" {
  value = {
    "fqdn"  = module.elasticsearch_2.fqdn,
    "alias" = module.elasticsearch_2.alias,
    "ip"    = module.elasticsearch_2.ip,
  }
}

output "elasticsearch_3" {
  value = {
    "fqdn"  = module.elasticsearch_3.fqdn,
    "alias" = module.elasticsearch_3.alias,
    "ip"    = module.elasticsearch_3.ip,
  }
}