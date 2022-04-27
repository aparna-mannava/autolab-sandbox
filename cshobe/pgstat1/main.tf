#destroy2
terraform {
  backend "s3" {}
}

locals {
  hostname = "us01vlpgstat1"
  domain = "auto.saas-n.com"
  tier = "dev"
  bt_env = "1"
  lob = "CLOUD"
  bt_product = "cloud"
  hostgroup = "BT pgBadger Server"
  environment = "feature_CLOUD_107809_pgbadger"
  cluster = "ny2-aze-ntnx-12"
  network = "ny2-autolab-db-ahv"
  datacenter = "ny2"
  os_version = "rhel8"
  cpus = "2"
  memory = "4096"
  additional_disks = {
    1 = "100"
  }
  facts = {
    "bt_env" = local.bt_env
    "bt_tier" = local.tier
    "bt_product" = local.bt_product
  }
}

module "pgbadger_1" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = local.hostname
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

output "pgbadger_1" {
  value = {
    "fqdn" = "${module.pgbadger_1.fqdn}",
    "alias" = "${module.pgbadger_1.alias}",
    "ip" = "${module.pgbadger_1.ip}",
  }
}
