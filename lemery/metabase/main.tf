terraform {
  backend "s3" {}
}

locals {
  facts       = {
    "bt_product" = "dgb"
    "bt_role" = "metabase"
    "bt_tier" = "dev"
    "bt_env"  = "2"
    "bt_foo"  = "bar"
  }
}

module "engine_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlmeta01"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "DGB"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "feature_CEA_8502_foreign_data_wrapper"
  foreman_hostgroup    = "BT PG Metabase DB Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
    2 = "100",
  }
}

output "engine_server_1" {
  value = {
    "fqdn"  = "${module.engine_server_1.fqdn}",
    "alias" = "${module.engine_server_1.alias}",
    "ip"    = "${module.engine_server_1.ip}",
  }
}
