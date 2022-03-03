terraform {
  backend "s3" {}
}

locals {
  etcd_servers = [
    "us01vlpgcs1e1",
    "us01vlpgcs1e2",
    "us01vlpgcs1e3"
  ]
  domain = "auto.saas-n.com"
  tier = "dev"
  bt_env = "3"
  lob = "CLOUD"
  bt_product = "cloud"
  bt_role = "postgresql"
  hostgroup = "BT ETCD for PostgreSQL Server"
  environment = "feature_CLOUD_103802_pgbadger"
  cluster = "ny5-aza-ntnx-16"
  network = "ny2-autolab-db-ahv"
  datacenter = "ny2"
  os_version = "rhel7"
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
    "bt_etcd_cluster_members" = [
      "${local.etcd_servers[0]}.${local.domain}",
      "${local.etcd_servers[1]}.${local.domain}",
      "${local.etcd_servers[2]}.${local.domain}"
    ]
  }
}

module "ny2_pgcs1_etcd_1" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "${local.etcd_servers[0]}"
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

module "ny2_pgcs1_etcd_2" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "${local.etcd_servers[1]}"
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

module "ny2_pgcs1_etcd_3" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "${local.etcd_servers[2]}"
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

output "ny2_pgcs1_etcd_1" {
  value = {
    "fqdn" = "${module.ny2_pgcs1_etcd_1.fqdn}",
    "alias" = "${module.ny2_pgcs1_etcd_1.alias}",
    "ip" = "${module.ny2_pgcs1_etcd_1.ip}",
  }
}

output "ny2_pgcs1_etcd_2" {
  value = {
    "fqdn" = "${module.ny2_pgcs1_etcd_2.fqdn}",
    "alias" = "${module.ny2_pgcs1_etcd_2.alias}",
    "ip" = "${module.ny2_pgcs1_etcd_2.ip}",
  }
}

output "ny2_pgcs1_etcd_3" {
  value = {
    "fqdn" = "${module.ny2_pgcs1_etcd_3.fqdn}",
    "alias" = "${module.ny2_pgcs1_etcd_3.alias}",
    "ip" = "${module.ny2_pgcs1_etcd_3.ip}",
  }
}
