terraform {
  backend "s3" {}
}
locals {
  facts       = {
    "bt_tier"    = "dev"
    "bt_product" = "cae"
    "bt_env"    = "1"
  }
}

module "streamset-service" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlbtiqset05" 
  bt_infra_network     = "ny2-autolab-db"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  os_version           = "rhel7"
  foreman_environment  = "feature_btiq_886"
  foreman_hostgroup    = "BTIQ CAE Streamsets"
  datacenter           = "ny2"
  lob                  = "dev"
  cpus                 = "2"
  memory               = "2048"
  additional_disks     = {
    1 = "200"
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
