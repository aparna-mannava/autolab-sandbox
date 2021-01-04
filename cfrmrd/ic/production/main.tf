terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
    }
    vm01facts    = {
      "bt_role"     = "app"
      "bt_tier"     = "dev"
      "bt_env"      = "qa2"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product"  = "${local.facts.bt_product}"
      "bt_ic_mode"  = "STANDALONE"
     }
     
     vm02facts    = {
      "bt_role"     = "app"
      "bt_tier"     = "dev"
      "bt_env"      = "staging"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product"  = "${local.facts.bt_product}"
      "bt_ic_mode"  = "BACKEND"
     }
     
     vm03facts    = {
      "bt_role"     = "app"
      "bt_tier"     = "ppd"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product"  = "${local.facts.bt_product}"
      "bt_ic_mode"  = "BACKEND"
     }
} 
 
module "app_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd551"
  alias                = "cfrmx-ic101"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_4396_IC_configuration_for_prod"
  foreman_hostgroup    = "CFRMRD Application PROD"
  datacenter           = "ny2"
  cpus                 = "1"
  memory         	   = "2048"
  additional_disks     = {
    1 = "50", // Disk 1
    2 = "100" //Disk 2
  }
} 

module "app_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd552"
  alias                = "cfrmx-ic102"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm02facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_4396_IC_configuration_for_prod"
  foreman_hostgroup    = "CFRMRD Application PROD"
  datacenter           = "ny2"
  cpus                 = "1"
  memory         	   = "2048"
  additional_disks     = {
    1 = "50", // Disk 1
    2 = "100" //Disk 2
  }
} 

module "app_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd553"
  alias                = "cfrmx-ic103"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm03facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_4396_IC_configuration_for_prod"
  foreman_hostgroup    = "CFRMRD Application PROD"
  datacenter           = "ny2"
  cpus                 = "1"
  memory         	   = "2048"
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

output "app_2" {
  value = {
    "fqdn"  = "${module.app_2.fqdn}",
    "alias" = "${module.app_2.alias}",
    "ip"    = "${module.app_2.ip}",
  }
}

output "app_3" {
  value = {
    "fqdn"  = "${module.app_3.fqdn}",
    "alias" = "${module.app_3.alias}",
    "ip"    = "${module.app_3.ip}",
  }
}