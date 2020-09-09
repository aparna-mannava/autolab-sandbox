terraform {
  backend "http" {}
}
locals {
  facts       = {
    "bt_product" = "cfrmrd"
    "bt_role"    = "app"
    "bt_tier"    = "dev"
    "bt_lob"     = "CFRM"
  }
}

module "standalone_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd100" 
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_2825_Add_user_jenkins"
  foreman_hostgroup    = "CFRMRD Application"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "100"
    1 = "100"
  }
}

output "standalone_1" {
  value = {
    "fqdn"  = "${module.standalone_1.fqdn}",
    "alias" = "${module.standalone_1.alias}",
    "ip"    = "${module.standalone_1.ip}",
   }
}