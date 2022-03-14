terraform {
  backend "s3" {}
}

locals {
  product     = "cfrm"
  datacenter  = "ny2"
  facts       = {
    "bt_product"         = "cfrmrd"
    "bt_customer"        = "cfrmrd"
    "bt_tier"            = "dev"
    "bt_env"             = "staging"
    "bt_role"            = "opensearch"
  }
}
  
module "cfrm_opensearch_1" { 
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmx101"
  alias                = "cfrm-opensearch-cluster1"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel8"  
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = "feature_CFRMX_7191_Opensearch"
  foreman_hostgroup    = "CFRMRD OpenSearch Cluster"
  lob                  = "CFRM"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = { 
    1 = "500",
    2 = "100",
  } 
} 

module "cfrm_opensearch_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmx102"
  alias                = "cfrm-opensearch-cluster2"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = "feature_CFRMX_7191_Opensearch"
  foreman_hostgroup    = "CFRMRD OpenSearch Cluster"
  lob                  = "CFRM"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "500",
    2 = "100",
  }  
}

module "cfrm_opensearch_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmx103"
  alias                = "cfrm-opensearch-cluster3"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = "feature_CFRMX_7191_Opensearch"
  foreman_hostgroup    = "CFRMRD OpenSearch Cluster"
  lob                  = "CFRM"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "500",
    2 = "100",  
  } 
}

output "cfrm_opensearch_1" {
  value = {
    "fqdn"  = module.cfrm_opensearch_1.fqdn,
    "alias" = module.cfrm_opensearch_1.alias,
    "ip"    = module.cfrm_opensearch_1.ip
  }
} 

output "cfrm_opensearch_2" {
  value = {
    "fqdn"  = module.cfrm_opensearch_2.fqdn,
    "alias" = module.cfrm_opensearch_2.alias,
    "ip"    = module.cfrm_opensearch_2.ip
  }
} 
output "cfrm_opensearch_3" {
  value = {
    "fqdn"  = module.cfrm_opensearch_3.fqdn,
    "alias" = module.cfrm_opensearch_3.alias,
    "ip"    = module.cfrm_opensearch_3.ip 
  }
}  