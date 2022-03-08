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
    "bt_role"            = "windows"
  }
}
  
module "cfrm_windows_1" { 
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwcfrm101"
  alias                = "cfrm-windows1"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7" 
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = "feature_CFRMX_8010_Windows_VM"
  foreman_hostgroup    = "CFRMRD Windows"
  lob                  = "CFRM"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = { 
    1 = "500",
    2 = "100",
  } 
}

output "cfrm_windows_1" {
  value = {
    "fqdn"  = module.cfrm_windows_1.fqdn,
    "alias" = module.cfrm_windows_1.alias,
    "ip"    = module.cfrm_windows_1.ip
  }
} 