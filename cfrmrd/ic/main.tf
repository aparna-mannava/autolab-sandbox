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

module "app_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd859"
  alias                = "cfrmx-staging-frontend2"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm01facts
  lob                  = "CFRM"
  foreman_environment  = "master"
  foreman_hostgroup    = "CFRMRD Application"
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