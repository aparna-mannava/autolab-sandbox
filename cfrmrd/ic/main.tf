terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_env" = ""
      "bt_role" = "ic"
    }
    app01facts    = {
      "bt_customer" = "saasn"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_role" = "${local.facts.bt_role}"
     }
}

module "app_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd51"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.app01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_1194_IC_installation"
  foreman_hostgroup    = "CFRMRD IC"
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