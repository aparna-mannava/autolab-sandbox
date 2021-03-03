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

module "oracle-pg-001" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vloraclepg001" 
  alias                = "oraclepg001" 
  bt_infra_cluster     = "ny2-azb-ntnx-09"
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

output "oracle-pg-001" {
  value = {
    "fqdn"  = "${module.oracle-pg-001.fqdn}",
    "alias" = "${module.oracle-pg-001.alias}",
    "ip"    = "${module.oracle-pg-001.ip}",
  }
  
}
