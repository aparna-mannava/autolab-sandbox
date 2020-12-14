terraform {
  backend "s3" {}
}
locals {
  facts       = {
    "bt_tier"    = "auto"
    "bt_product" = "shared"
    "bt_role" = "postgresql"
    "bt_env"    = "2"
    "bt_pg_version" = "12"
  }
}

module "pg-bkp-07" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpgbkp07" 
  alias                = "pgbkptesting07" 
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Postgresql DB Server" 
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

output "pg-bkp-07" {
  value = {
    "fqdn"  = "${module.pg-bkp-07.fqdn}",
    "alias" = "${module.pg-bkp-07.alias}",
    "ip"    = "${module.pg-bkp-07.ip}",
  }
  
}
