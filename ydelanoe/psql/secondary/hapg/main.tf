terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vletcdfm04","us01vletcdfm05","us01vletcdfm06"]
  hapg_servers    = ["us01vlpgfm0004","us01vlpgfm0005","us01vlpgfm0006"]
  haproxy_server  = ["us01vlhapxfm02"]
  backrest_server = ["us01vlbkpfm002"]
  etcd_hosts_p    = ["'us01vletcdfm04.auto.saas-n.com','us01vletcdfm05.auto.saas-n.com','us01vletcdfm06.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  os_version      = "rhel7"
  tier            = "dev"
  bt_env          = "1"
  bt_product      = "fmcloud"
  lob             = "fmcloud"
  environment     = "master"
  cluster         = "ny2-aze-ntnx-12"
  network         = "ny2-autolab-app-ahv"
  etcd_hostgroup  = "BT ETCD for PostgreSQL Server"
  pg_hostgroup    = "BT HA PG Server"
  hapxy_hostgroup = "BT Patroni HA Proxy"
  pg_datacenter   = "ny2"
  pg_tier         = "dev"
  pg_cluster_node = "secondary"
  pg_cluster_ms   = "fm"
  facts           = {
    "bt_pg_version"           = "12"
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}", "${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_cluster_name"         = "${local.pg_cluster_node}-${local.pg_cluster_ms}"
  }
}

module "pg_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.hapg_servers[0]
  alias                = "fm-${local.pg_datacenter}-${local.pg_tier}-${lower(local.facts.bt_cluster_name)}-pg1"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.pg_hostgroup
  foreman_environment  = local.environment
  os_version           = local.os_version
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
    2 = "100",
  }
}

module "pg_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.hapg_servers[1]
  alias                = "fm-${local.pg_datacenter}-${local.pg_tier}-${lower(local.facts.bt_cluster_name)}-pg2"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.pg_hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = local.os_version
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
    2 = "100",
  }
}

module "pg_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.hapg_servers[2]
  alias                = "fm-${local.pg_datacenter}-${local.pg_tier}-${lower(local.facts.bt_cluster_name)}-pg3"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.pg_hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = local.os_version
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
    2 = "100",
  }
}

module "haproxy_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.haproxy_server[0]
  alias                = "fm-${local.pg_datacenter}-${local.pg_tier}-${lower(local.facts.bt_cluster_name)}-haproxy1"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hapxy_hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = local.os_version
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
    2 = "10",
  }
}

output "pg_0" {
  value = {
    "fqdn"  = module.pg_0.fqdn,
    "alias" = module.pg_0.alias,
    "ip"    = module.pg_0.ip,
  }
}

output "pg_1" {
  value = {
    "fqdn"  = module.pg_1.fqdn,
    "alias" = module.pg_1.alias,
    "ip"    = module.pg_1.ip,
  }
}

output "pg_2" {
  value = {
    "fqdn"  = module.pg_2.fqdn,
    "alias" = module.pg_2.alias,
    "ip"    = module.pg_2.ip,
  }
}

output "haproxy_0" {
  value = {
    "fqdn"  = module.haproxy_0.fqdn,
    "alias" = module.haproxy_0.alias,
    "ip"    = module.haproxy_0.ip,
  }
}