terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
     
    }
    vm01facts    = {
      "bt_role" = "runner"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
     }
} 

module "app_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd300"
  alias                = "cfrmx-gitlab-runner1"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_4492_gitlab_poc"
  foreman_hostgroup    = "CFRMRD GitLab Runner"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50", // Disk 1
    2 = "100" //Disk 2
  }
}  
 
output "app_1" {
  value = {
    "fqdn"  = "${module.app_1.fqdn}",
    "alias" = "${module.app_1.alias}",
    "ip"    = "${module.app_1.ip}",
  }
}