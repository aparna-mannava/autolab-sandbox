terraform {
  backend "http" {}
}

locals {
  product     = "dgb"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "1"
    "bt_customer" = "fi9990"
  }
}

module "dgb_oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfdemo199"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel6"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT DGB Oradb Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  lob                  = "CLOUD"
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200",
    4 = 200
  }
}

output "dgb_oradb_server_1" {
  value = {
    "fqdn"  = "${module.dgb_oradb_server_1.fqdn}",
    "ip"    = "${module.dgb_oradb_server_1.ip}",
  }
}
