terraform {
  backend "http" {}
}

locals {
  product     = "dgb"
  environment = "feature_CLOUD_67786"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "demo"
    "bt_env"  = "2"
    "bt_customer" = "fi6010"
  }
}

module "oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfdemo36"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-dm36"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT DGB Oradb Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "50",
    3 = "50"
  }
}

output "oradb_server_1" {
  value = {
    "fqdn"  = "${module.oradb_server_1.fqdn}",
    "alias" = "${module.oradb_server_1.alias}",
    "ip"    = "${module.oradb_server_1.ip}",
  }
}
