terraform {
  backend "s3" {}
}

locals {
  etcd_servers = ["us01vlpgcs1e1", "us01vlpgcs1e2", "us01vlpgcs1e3"]
  hapg_servers    = ["us01vlpgcs1p1", "us01vlpgcs1p2"]
  haproxy_server  = ["us01vlpgcs1h1"]
  backrest_server = ["us01vlpgcs1b1"]
  domain = "auto.saas-n.com"
  tier = "dev"
  bt_env = "3"
  lob = "CLOUD"
  bt_product = "cloud"
  bt_role = "postgres"
  hostgroup = "BT HA PG Server"
  environment = "master"
  cluster = "ny5-azc-ntnx-16"
  network = "ny2-autolab-db-ahv"
  datacenter = "ny2"
  os_version = "rhel8"
  cpus = "2"
  memory = "4096"
  additional_disks = {
    1 = "32",
    2 = "128",
    3 = "128",
  }
  facts = {
    "bt_env" = local.bt_env
    "bt_tier" = local.tier
    "bt_product" = local.bt_product
    "bt_role" = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
    "bt_hapg_node1" = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2" = "${local.hapg_servers[1]}.${local.domain}"
    "bt_backup_node" = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name" = "pgcs1"
    "bt_pg_version" = "13"
  }
}

module "ny2_autolab_hapg_0" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "${local.hapg_servers[0]}"
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

module "ny2_autolab_hapg_1" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "${local.hapg_servers[1]}"
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

output "ny2_autolab_hapg_0" {
  value = {
    "fqdn" = "${module.ny2_autolab_hapg_0.fqdn}",
    "alias" = "${module.ny2_autolab_hapg_0.alias}",
    "ip" = "${module.ny2_autolab_hapg_0.ip}",
  }
}

output "ny2_autolab_hapg_1" {
  value = {
    "fqdn" = "${module.ny2_autolab_hapg_1.fqdn}",
    "alias" = "${module.ny2_autolab_hapg_1.alias}",
    "ip" = "${module.ny2_autolab_hapg_1.ip}",
  }
}