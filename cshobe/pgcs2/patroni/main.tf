terraform {
  backend "s3" {}
  required_providers {
    infoblox = {
      source = "terraform.bottomline.com/automation/infoblox"
      version = "1.1.1"
    }
  }
}

locals {
  etcd_servers = [
    "us01vlpgcs1e1"
  ]
  patroni_servers = [
    "us01vlpgcs2p1",
    "us01vlpgcs2p2"
  ]
  pgbackrest_server = "us01vlpgcs1b1"
  domain = "auto.saas-n.com"
  tier = "dev"
  bt_env = "3"
  lob = "CLOUD"
  bt_product = "cloud"
  hostgroup = "BT HA PG Server"
  environment = "feature_CLOUD_103272_testing"
  cluster = "ny5-aza-ntnx-14"
  network = "ny2-autolab-db-ahv"
  network_subnet = "10.226.191.0/24"
  datacenter = "ny2"
  os_version = "rhel8"
  cpus = "2"
  memory = "4096"
  additional_disks = {
    1 = "4",
    2 = "32"
  }
  cluster_name = "pgcs2"
  facts = {
    "bt_env" = local.bt_env
    "bt_tier" = local.tier
    "bt_product" = local.bt_product
    "bt_etcd_cluster_members" = [
      "${local.etcd_servers[0]}.${local.domain}"
    ]
    "bt_hapg_cluster_members" = [
      "${local.patroni_servers[0]}.${local.domain}",
      "${local.patroni_servers[1]}.${local.domain}"
    ]
    "bt_hapg_node1" = "${local.patroni_servers[0]}.${local.domain}"
    "bt_hapg_node2" = "${local.patroni_servers[1]}.${local.domain}"
    "bt_backup_node" = "${local.pgbackrest_server}.${local.domain}"
    "bt_cluster_name" = local.cluster_name
    "bt_pg_version" = "12"
    "bt_patroni_master_vip_hostname" = "${local.cluster_name}.${local.domain}"
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

module "patroni_2" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "${local.patroni_servers[1]}"
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

resource "infoblox_record_host" "vip" {
  configure_for_dns = true
  name              = "pgcs2.auto.saas-n.com"
  view              = "default"
  ipv4addr {
    configure_for_dhcp = false
    function           = "func:nextavailableip:${local.network_subnet}"
  }
}

output "patroni_1" {
  value = {
    "fqdn" = "${module.patroni_1.fqdn}",
    "alias" = "${module.patroni_1.alias}",
    "ip" = "${module.patroni_1.ip}",
  }
}

output "patroni_2" {
  value = {
    "fqdn" = "${module.patroni_2.fqdn}",
    "alias" = "${module.patroni_2.alias}",
    "ip" = "${module.patroni_2.ip}",
  }
}