terraform {
  backend "s3" {}
}

locals {
  puppet_env    = "master"
  datacenter    = "ny2"
  domain        = "auto.saas-n.com"
  lob           = "dgb"
  facts         = {
    "bt_customer"         = "fi9999" #ex: fiXXXX
    "bt_tier"             = "pr" #ex: sbx, tst, td, demo
    "bt_env"              = "" #ex: leave blank for first env, or non-zero-padded number
    "bt_product"          = "dgb"
  }
}

module "db_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlauto057" #ex: us01vldgbdbXXX
  os_version           = "rhel7"
  alias                = "${local.lob}-pci-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-oradb01"
  datacenter           = local.datacenter
  bt_infra_network     = "ny2-autolab-db-ahv"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = "BT DGB Oradb Server" #ex: BT DGB Oradb Server
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "65536"
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}


output "db_server_1" {
  value = {
    "fqdn"  = "${module.db_server_1.fqdn}",
    "alias" = "${module.db_server_1.alias}",
    "ip"    = "${module.db_server_1.ip}",
  }
}

module "db_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlauto058" #ex: us01vldgbdbXXX
  os_version           = "rhel7"
  alias                = "${local.lob}-pci-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-oradb01"
  datacenter           = local.datacenter
  bt_infra_network     = "ny2-autolab-db-ahv"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = "BT DGB Oradb Server" #ex: BT DGB Oradb Server
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "65536"
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}


output "db_server_2" {
  value = {
    "fqdn"  = "${module.db_server_1.fqdn}",
    "alias" = "${module.db_server_1.alias}",
    "ip"    = "${module.db_server_1.ip}",
  }
}

