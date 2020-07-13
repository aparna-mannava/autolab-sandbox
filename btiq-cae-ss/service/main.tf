terraform {
  backend "http" {}
}
locals {
  facts       = {
    "bt_tier"    = "dev"
    "bt_product" = "inf"
    "bt_env"    = "1"
  }
}

module "streamset-service" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcaesset02" 
  bt_infra_network     = "ny2-autolab-db"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Streamsets Server"
  datacenter           = "ny2"
  lob                  = "dev"
  cpus                 = "2"
  memory        	   = "2048"
  additional_disks     = {
    1 = "20"
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
