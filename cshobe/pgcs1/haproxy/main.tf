terraform {
  backend "s3" {}
}

locals {
  patroni_servers = [
    "us01vlpgcs1p1",
    "us01vlpgcs1p2"
  ]
  haproxy_servers = [
    "us01vlpgcs1h1"
  ]
  domain = "auto.saas-n.com"
  tier = "dev"
  bt_env = "3"
  lob = "CLOUD"
  bt_product = "cloud"
  hostgroup = "BT Patroni HA Proxy"
  environment = "feature_CLOUD_103802_pgbadger"
  cluster = "ny5-aza-ntnx-14"
  network = "ny2-autolab-db-ahv"
  datacenter = "ny2"
  os_version = "rhel8"
  cpus = "2"
  memory = "4096"
  additional_disks = {
    1 = "32",
    2 = "8"
  }
  facts = {
    "bt_env" = local.bt_env
    "bt_tier" = local.tier
    "bt_product" = local.bt_product
    "bt_hapg_cluster_members" = [
      "${local.patroni_servers[0]}.${local.domain}",
      "${local.patroni_servers[1]}.${local.domain}"
    ]
    "bt_hapg_node1" = "${local.patroni_servers[0]}.${local.domain}"
    "bt_hapg_node2" = "${local.patroni_servers[1]}.${local.domain}"
  }
}

module "ny2_pgcs1_haproxy_1" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "${local.haproxy_servers[0]}"
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

output "ny2_pgcs1_haproxy_1" {
  value = {
    "fqdn" = "${module.ny2_pgcs1_haproxy_1.fqdn}",
    "alias" = "${module.ny2_pgcs1_haproxy_1.alias}",
    "ip" = "${module.ny2_pgcs1_haproxy_1.ip}",
  }
}
