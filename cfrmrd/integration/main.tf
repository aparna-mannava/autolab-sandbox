terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_env" = ""
      "bt_role" = "app"
    }
    app01facts    = {
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_role" = "${local.facts.bt_role}"
     }
    app02facts    = {
      "bt_customer" = "bb"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_role" = "${local.facts.bt_role}"
     }
}

module "app_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd31"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.app01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_24317_add_nfs"
  foreman_hostgroup    = "CFRMRD Application"
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
  hostname             = "us01vlcfrmrd32"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.app02facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_24317_add_nfs"
  foreman_hostgroup    = "CFRMRD Application"
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