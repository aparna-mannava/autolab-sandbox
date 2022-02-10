terraform {
  backend "s3" {}
}

locals {
etcd_servers = ["us01vlted011","us01vlted012","us01vlted013"]
hapg_servers = ["us01vlthpg011","us01vlthpg012","us01vlthpg013"]
haproxy_server = ["us01vlthxp011"]
backrest_server = ["us01vltbkst011"]
etcd_hosts_p = ["'us01vlted011.saas-n.com','us01vlted012.saas-n.com','us01vlted013.saas-n.com'"]
domain          = "auto.saas-n.com"
tier            = "nonprod"
bt_env          = "key-rotate01"
lob             = "DGB"
bt_product      = "dgb"
bt_role           = "postgresql"
hostgroup       = "BT ETCD for PostgreSQL Server"
environment     = "master"
cluster         = "ny5-azc-ntnx-16"
network         = "ny2-autolab-app-ahv"
datacenter      = "ny2"
 facts           = {
"bt_env"                  = local.bt_env
"bt_tier"                 = local.tier
"bt_product"              = local.bt_product
"bt_role"                   = local.bt_role
"bt_pg_version"			= "12"
"bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
"bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}", "${local.hapg_servers[2]}.${local.domain}"]
"bt_hapg_node1" = "${local.hapg_servers[0]}.${local.domain}"
"bt_hapg_node2" = "${local.hapg_servers[1]}.${local.domain}"
"bt_hapg_node3" = "${local.hapg_servers[2]}.${local.domain}"
"bt_backup_node" = "${local.backrest_server[0]}.${local.domain}"
  }
}

module "vault_etcd_11" {
source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
hostname = "${local.etcd_servers[0]}"
bt_infra_cluster = local.cluster
bt_infra_network = local.network
lob = local.lob
foreman_hostgroup = local.hostgroup
foreman_environment = local.environment
os_version = "rhel7"
cpus = "1"
memory = "4096"
external_facts = local.facts
datacenter = "ny2"
additional_disks = {
1 = "100",
}
}

module "vault_etcd_12" {
source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
hostname = "${local.etcd_servers[1]}"
bt_infra_cluster = local.cluster
bt_infra_network = local.network
foreman_hostgroup = local.hostgroup
foreman_environment = local.environment
lob = local.lob
os_version = "rhel7"
cpus = "1"
memory = "4096"
external_facts = local.facts
datacenter = "ny2"
additional_disks = {
1 = "100",
}
}

module "vault_etcd_13" {
source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
hostname = "${local.etcd_servers[2]}"
bt_infra_cluster = local.cluster
bt_infra_network = local.network
foreman_hostgroup = local.hostgroup
lob = local.lob
foreman_environment = local.environment
os_version = "rhel7"
cpus = "1"
memory = "4096"
external_facts = local.facts
datacenter = "ny2"
additional_disks = {
1 = "100",
}
}

output "vault_etcd_11" {
value = {
"fqdn" = module.vault_etcd_11.fqdn,
"alias" = module.vault_etcd_11.alias,
"ip" = module.vault_etcd_11.ip,
}
}

output "vault_etcd_12" {
value = {
"fqdn" = module.vault_etcd_12.fqdn,
"alias" = module.vault_etcd_12.alias,
"ip" = module.vault_etcd_12.ip,
}
}

output "vault_etcd_13" {
value = {
"fqdn" = module.vault_etcd_13.fqdn,
"alias" = module.vault_etcd_13.alias,
"ip" = module.vault_etcd_13.ip,
}
}