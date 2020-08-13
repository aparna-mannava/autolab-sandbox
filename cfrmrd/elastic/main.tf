terraform {
  backend "http" {}
}
locals {
  facts       = {
    "bt_product" = "cfrmrd"
    "bt_role"    = "standalone"
    "bt_tier"    = "dev"
    "bt_lob"     = "CFRMRD"
  }
}

module "artemis_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd017" 
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  external_facts       = local.facts
  lob                  = "CFRMRD"
  foreman_environment  = "feature_CFRMX_1192_elastic"
  foreman_hostgroup    = "CFRMRD Elastic Server"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50"
    1 = "150"
  }
}


output "artemis_1" {
  value = {
    "fqdn"  = "${module.artemis_1.fqdn}",
    "alias" = "${module.artemis_1.alias}",
    "ip"    = "${module.artemis_1.ip}",
   }
}   