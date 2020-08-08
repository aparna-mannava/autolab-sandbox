terraform {
  backend "s3" {}
}
locals {
  facts       = {
    "bt_tier"    = "dev"
    "bt_product" = "btiq"
    "bt_role" = "postgresql"
    "bt_env"    = ""
  }
}

module "pg-service" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlbtiqdb02" 
  alias                = "btiq_cae_pgrz_auto_01" 
  bt_infra_cluster     = "ny2-azd-ntnx-10"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "feature_btiq_pg_198"
  foreman_hostgroup    = "BT BTIQ PG Server"
  datacenter           = "ny2"
  lob                  = "dev"
  cpus                 = "4"
  memory               = "4098"
  additional_disks     = {
    1 = "100"
    2 = "200"
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