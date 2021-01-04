terraform {
  backend "s3" {}
}
locals {
  facts       = {
    "bt_tier"    = "auto"
    "bt_product" = "cloud"
    "bt_role" = "streamsets"
    "bt_env"    = "2"
  }
}

module "pg-service" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlsstst1" 
  alias                = "sstest01" 
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Streamsets Server" 
  datacenter           = "ny2"
  lob                  = "cloud"
  cpus                 = "4"
  memory               = "4098"
  additional_disks     = {
    1 = "100"
    2 = "50"
  }
  external_facts       = local.facts
}

output "pg-service" {
  value = {
    "fqdn"  = "${module.pg-service.fqdn}",
    "alias" = "${module.pg-service.alias}",
    "ip"    = "${module.pg-service.ip}",
  }
  
}
