terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
      "bt_env" = "autolab"
    }
    vm01facts    = {
      "bt_role" = "app"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
     }
} 

module "app_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd860"
  alias                = "cfrmx-staging-frontend3"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_3987_IC_configuration_refining"
  foreman_hostgroup    = "CFRMRD Application SSL"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50", // Disk 1
    2 = "100" //Disk 2
  }
}  

output "app_2" {
  value = {
    "fqdn"  = "${module.app_2.fqdn}",
    "alias" = "${module.app_2.alias}",
    "ip"    = "${module.app_2.ip}",
  }
}   