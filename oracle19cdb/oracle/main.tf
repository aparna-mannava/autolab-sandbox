terraform {
  backend "http" {}
}

locals {
  environment = "feature_CLOUD_73533"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "3"
  }
}

module "bb_oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlbboradb53"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT BB Oradb Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "20",
    3 = "20"
  }
}

output "bb_oradb_server_1" {
  value = {
    "fqdn"  = "${module.bb_oradb_server_1.fqdn}",
    "ip"    = "${module.bb_oradb_server_1.ip}",
  }
}
