terraform {
  backend "s3" {}
}

locals {
  etcd_servers = [
    "us01vlpgcs3e1",
    "us01vlpgcs3e2",
    "us01vlpgcs3e3"
  ]
  patroni_servers = [
    "us01vlpgcs3p1"
  ]
  pgbackrest_server = "us01vlpgcs3b1"
  domain = "auto.saas-n.com"
  tier = "dev"
  bt_env = "3"
  lob = "CLOUD"
  bt_product = "cloud"
  hostgroup = "BT HA PG Server"
  environment = "feature_CLOUD_104123_patroni_exporter"
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
    "bt_etcd_cluster_members" = [
      "${local.etcd_servers[0]}.${local.domain}",
      "${local.etcd_servers[1]}.${local.domain}",
      "${local.etcd_servers[2]}.${local.domain}"
    ]
    "bt_hapg_cluster_members" = [
      "${local.patroni_servers[0]}.${local.domain}"
    ]
    "bt_hapg_node1" = "${local.patroni_servers[0]}.${local.domain}"
    "bt_backup_node" = "${local.pgbackrest_server}.${local.domain}"
    "bt_cluster_name" = "pgcs1"
    "bt_pg_version" = "13"
  }
}

module "patroni_1" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "${local.patroni_servers[0]}"
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

output "patroni_1" {
  value = {
    "fqdn" = "${module.patroni_1.fqdn}",
    "alias" = "${module.patroni_1.alias}",
    "ip" = "${module.patroni_1.ip}",
  }
}
