terraform {
  backend "http" {}
}

locals {
  product     = "cfrm"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "sbx"
    "bt_env"  = "2"
    "bt_customer" = "dgbcs"
    "bt_product" = "cfrm"
    "bt_role" = "oradb"
  }
}

module "oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfdemo117"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-wpdgbts"
  bt_infra_environment = "ny2-autolab-app"
  os_version           = "rhel6"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT CFRM SP Oracle Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200",
    7 = 200
  }
}

output "oradb_server_1" {
  value = {
    "fqdn"  = "${module.oradb_server_1.fqdn}",
    "alias" = "${module.oradb_server_1.alias}",
    "ip"    = "${module.oradb_server_1.ip}",
  }
}

module "oradb_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltfdemo125"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-wpdgb"
  bt_infra_environment = "ny2-autolab-app"
  os_version           = "rhel6"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT CFRM SP Oracle Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200",
    7 = 200
  }
}

output "oradb_server_2" {
  value = {
    "fqdn"  = "${module.oradb_server_2.fqdn}",
    "alias" = "${module.oradb_server_2.alias}",
    "ip"    = "${module.oradb_server_2.ip}",
  }
}
