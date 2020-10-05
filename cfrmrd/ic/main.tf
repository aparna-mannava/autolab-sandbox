terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "saasn"
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_env" = ""
      "bt_role" = "ic"
      "bt_ic_version" = "6.3"
    }
    app01facts    = {
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_role" = "${local.facts.bt_role}"
      "bt_ic_version" = "${local.facts.bt_ic_version}"
      "bt_ic_mode" = "FRONTEND"
     }

     app02facts    = {
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_role" = "${local.facts.bt_role}"
      "bt_ic_version" = "${local.facts.bt_ic_version}"
      "bt_ic_mode" = "BACKEND"
     }
}

module "app_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd52"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.app01facts
  foreman_environment  = "feature_CFRMX_1194_IC"
  foreman_hostgroup    = "CFRMRD IC"
  lob                  = "CFRM"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}
 
module "app_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd62"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.app02facts
  foreman_environment  = "feature_CFRMX_1194_IC"
  foreman_hostgroup    = "CFRMRD IC"
  lob                  = "CFRM"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50",
    2 = "100"
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