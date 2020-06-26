terraform {
  backend "http" {}
}
module "streamset-service" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcaesset01" 
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  lob                  = "btiq-cae"
  cpus                 = "2"
  memory        	   = "2048"
  additional_disks     = {
    1 = "20"
  }
  external_facts       = {
    "bt_tier" = "dev",
    "bt_product"       = "btiq_cae"
    "bt_role"          = "streamset"
 }
}

output "streamset-service" {
  value = {
    "fqdn"  = "${module.streamset-service.fqdn}",
    "alias" = "${module.streamset-service.alias}",
    "ip"    = "${module.streamset-service.ip}",
  }
  
}

