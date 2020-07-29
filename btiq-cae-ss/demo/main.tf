terraform {
  backend "http" {}
}
locals {
  facts       = {
    "bt_tier"    = "dev"
    "bt_product" = "btiq_cae"
    "bt_role"    = "streamsets"
  }
}
module "streamset-service" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcaesset01" 
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  foreman_environment  = "feature_btiq_cae_ss"
  foreman_hostgroup    = "BTIQ CAE Streamsets"
  datacenter           = "ny2"
  lob                  = "btiq_cae"
  cpus                 = "2"
  memory         	= "2048"
  additional_disks     = {
    1 = "50"
  }
  external_facts       = local.facts
}


output "streamset-service" {
  value = {
    "fqdn"  = "${module.streamset-service.fqdn}",
    "alias" = "${module.streamset-service.alias}",
    "ip"    = "${module.streamset-service.ip}",
  }
  
}
