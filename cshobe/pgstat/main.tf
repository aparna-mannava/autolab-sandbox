terraform {
  backend "s3" {}
}

locals {
  pgbadger_server = "us01vlpgstat1"
  domain = "auto.saas-n.com"
  tier = "dev"
  bt_env = "3"
  lob = "CLOUD"
  bt_product = "cloud"
  bt_role = "postgresql"
  hostgroup = "BT pgBadger Server"
  environment = "feature_CLOUD_103802_pgbadger"
  cluster = "ny5-aza-ntnx-14"
  network = "ny2-autolab-db-ahv"
  datacenter = "ny2"
  os_version = "rhel8"
  cpus = "2"
  memory = "4096"
  additional_disks = {
    1 = "32"
  }
  facts = {
    "bt_env" = local.bt_env
    "bt_tier" = local.tier
    "bt_product" = local.bt_product
    "bt_role" = local.bt_role
  }
}

module "ny2_pgstat1" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = local.pgbadger_server
  bt_infra_cluster = local.cluster
  bt_infra_network = local.network
  lob = local.lob
  foreman_hostgroup = local.hostgroup
  foreman_environment = local.environment
  datacenter = local.datacenter
  os_version = local.os_version
  cpus = local.cpus
  memory = local.memory
  external_facts = local.facts
  additional_disks = local.additional_disks
}

output "ny2_pgstat1" {
  value = {
    "fqdn" = "${module.ny2_pgstat1.fqdn}",
    "alias" = "${module.ny2_pgstat1.alias}",
    "ip" = "${module.ny2_pgstat1.ip}",
  }
}
