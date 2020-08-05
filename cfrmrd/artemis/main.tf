terraform {
  backend "http" {}
}
locals {
  facts       = {
    "bt_product" = "cfrmrd"
    "bt_role"    = "standalone"
  }
}

module "artemis_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd015" 
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  lob                  = "CFRMRD"
  foreman_environment  = "feature_CFRMX_1193_artemis"
  foreman_hostgroup    = "CFRMRD Artemis Server"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	= "4096"
  additional_disks     = {
    1 = "50"
    1 = "150"
  }
  external_facts       = local.facts
}


output "artemis_1" {
  value = {
    "fqdn"  = "${module.artemis_1.fqdn}",
    "alias" = "${module.artemis_1.alias}",
    "ip"    = "${module.artemis_1.ip}",
   }
}   