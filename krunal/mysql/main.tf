terraform {
  backend "http" {}
}

locals {
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "pr"
    "bt_env"  = "1"
    "bt_product"  = "cagso"
    "bt_role" = "db"
  }
}

module "oradb_oflows_server" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfoflows01"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-db"
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "20",
    3 = "10"
  }
}

output "oradb_oflows_server" {
  value = {
    "fqdn"  = "${module.oradb_oflows_server.fqdn}",
    "ip"    = "${module.oradb_oflows_server.ip}",
  }
}
