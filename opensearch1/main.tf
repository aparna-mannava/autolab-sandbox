terraform {
  backend "s3" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_env" = "devops"
      "bt_role" = "test"
    } 
    os01facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = local.facts.bt_role
      "bt_opensearch_mode" = "cluster"
     }
    os02facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = local.facts.bt_role
      "bt_opensearch_mode" = "cluster"
     }
    os03facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = local.facts.bt_role
      "bt_opensearch_mode" = "cluster"
    }
}

module "artemis_apacheds_opensearch_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd777"
  alias                = "cfrmrd-opensearch1"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  os_version           = "rhel7"
  external_facts       = local.os01facts
  lob                  = "CFRM"
  foreman_environment  = "master"
  foreman_hostgroup    = "CFRMRD OpenSearch Cluster"
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
  hostname             = "us01vlcfrmrd888"
  alias                = "cfrmrd-opensearch2"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  os_version           = "rhel7"
  external_facts       = local.os02facts
  lob                  = "CFRM"
  foreman_environment  = "master"
  foreman_hostgroup    = "CFRMRD OpenSearch Cluster"
  datacenter           = "ny2"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "100",
    2 = "100"
  } 
}

module "opensearch_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd999"
  alias                = "cfrmrd-opensearch3"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  os_version           = "rhel7"
  external_facts       = local.os03facts
  lob                  = "CFRM"
  foreman_environment  = "master"
  foreman_hostgroup    = "CFRMRD OpenSearch Cluster"
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

output "opensearch_3" {
  value = {
    "fqdn"  = module.opensearch_3.fqdn,
    "alias" = module.opensearch_3.alias,
    "ip"    = module.opensearch_3.ip,
  }
}