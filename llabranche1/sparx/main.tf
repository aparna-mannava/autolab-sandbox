terraform {
  backend "s3" {}
}
 
locals {
  product     = "autolab"
  environment = "nonprod"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "1"
    "bt_pg_version" = "12"
  }
}
 
module "dbps_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltdps010"
  alias                = "${local.product} -${local.facts.bt_tier}${local.facts.bt_env}${local.facts.bt_pg_version}-db01"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Postgresql DB Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "100",
    2 = "200"
  }
}

output "dbps_server_1" {
  value = {
    "fqdn"  = "${module.dbps_server_1.fqdn}",
    "alias" = "${module.dbps_server_1.alias}",
    "ip"    = "${module.dbps_server_1.ip}",
  }
} 
