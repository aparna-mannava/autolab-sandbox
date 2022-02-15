terraform {
  backend "s3" {}
}

locals {
  pg_server = "us01vlpgcs2p1"
  domain = "auto.saas-n.com"
  tier = "dev"
  bt_env = "3"
  lob = "CLOUD"
  bt_product = "cloud"
  hostgroup = "BT Postgresql DB Server"
  environment = "feature_CLOUD_103802_pgbadger"
  cluster = "ny5-aza-ntnx-14"
  network = "ny2-autolab-db-ahv"
  datacenter = "ny2"
  os_version = "rhel8"
  cpus = "2"
  memory = "4096"
  additional_disks = {
    1 = "4",
    2 = "32"
  }
  facts = {
    "bt_env" = local.bt_env
    "bt_tier" = local.tier
    "bt_product" = local.bt_product
    "bt_pg_version" = "12"
  }
}

module "postgresql_1" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = local.pg_server
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

output "postgresql_1" {
  value = {
    "fqdn" = "${module.postgresql_1.fqdn}",
    "alias" = "${module.postgresql_1.alias}",
    "ip" = "${module.postgresql_1.ip}",
  }
}
