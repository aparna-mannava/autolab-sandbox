terraform {
  backend "s3" {}
}

locals {
  patroni_servers = [
    "us01vlpgcs1p1",
    "us01vlpgcs1p2"
  ]
  pgbackrest_server = "us01vlpgcs1b1"
  domain = "auto.saas-n.com"
  tier = "dev"
  bt_env = "3"
  lob = "CLOUD"
  bt_product = "cloud"
  bt_role = "postgresql"
  hostgroup = "BT PG Backrest Server"
  environment = "master"
  cluster = "ny2-azb-ntnx-08"
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
    "bt_role" = local.bt_role
    "bt_hapg_cluster_members" = [
      "${local.patroni_servers[0]}.${local.domain}",
      "${local.patroni_servers[1]}.${local.domain}"
    ]
    "bt_backup_node" = "${local.pgbackrest_server}.${local.domain}"
  }
}

module "ny2_pgcs1_pgbackrest_1" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = local.pgbackrest_server
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

output "ny2_pgcs1_pgbackrest_1" {
  value = {
    "fqdn" = "${module.ny2_pgcs1_pgbackrest_1.fqdn}",
    "alias" = "${module.ny2_pgcs1_pgbackrest_1.alias}",
    "ip" = "${module.ny2_pgcs1_pgbackrest_1.ip}",
  }
}
