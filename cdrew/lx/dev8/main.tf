terraform {
  backend "s3" {}
}
locals {
  facts       = {
    "bt_tier"    = "dev"
    "bt_product" = "lx"
    "bt_role" = "postgresql"
    "bt_env"    = "8"
  }
}

module "pg-service" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vllxdb11" 
  alias                = "lx-tst-key" 
  bt_infra_cluster     = "ny2-azd-ntnx-10"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "feature_CEA_8322_lsm"
  foreman_hostgroup    = "BT LX Keycloak PG standalone"
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
