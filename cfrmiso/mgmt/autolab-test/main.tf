terraform {
  backend "s3" {}
}
 
locals {
    facts       = {
      "bt_customer" = ""
      "bt_product"  = "cfrmcloud"
    }
    vm01facts    = {
      "bt_tier" = "autolab"
      "bt_role" = "mgmt"
      "bt_env" = ""
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
     }  
} 
 
module "mgmt_951" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmmg951"
  alias                = "cfrmcloud-autolab-mgnf-clinet"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-services-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMCLOUD_824_cfrm_cloud_user_key"
  foreman_hostgroup    = "BT CFRM CLOUD MGMT Base test"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "150", // Disk 1
  }
} 

  

output "mgmt_951" {
  value = {
    "fqdn"  = module.mgmt_951.fqdn,
    "alias" = module.mgmt_951.alias,
    "ip"    = module.mgmt_951.ip,
  }
} 
  