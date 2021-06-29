terraform {
  backend "s3" {}
}
#
locals {
  etcd_servers    = ["us01vletcdfm01","us01vletcdfm02","us01vletcdfm03"]
  hapg_servers    = ["us01vlpgfm0001","us01vlpgfm0002","us01vlpgfm0003"]
  haproxy_server  = ["us01vlhapxfm01"]
  backrest_server = ["us01vlbkpfm001"]
  etcd_hosts_p    = ["'us01vletcdfm01.saas-n.com','us01vletcdfm02.saas-n.com','us01vletcdfm03.saas-n.com'"]
  domain          = "saas-n.com"
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
  pg_cluster_node = "primary"
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

module "etcd_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.etcd_servers[0]
  alias                = "fm-${local.pg_datacenter}-${local.pg_tier}-${lower(local.facts.bt_cluster_name)}-etcd1"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.etcd_hostgroup
  foreman_environment  = local.environment
  os_version           = local.os_version
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

module "etcd_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.etcd_servers[1]
  alias                = "fm-${local.pg_datacenter}-${local.pg_tier}-${lower(local.facts.bt_cluster_name)}-etcd2"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.etcd_hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = local.os_version
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

module "etcd_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.etcd_servers[2]
  alias                = "fm-${local.pg_datacenter}-${local.pg_tier}-${lower(local.facts.bt_cluster_name)}-etcd3"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.etcd_hostgroup
  lob                  = local.lob
  foreman_environment  = local.environment
  os_version           = local.os_version
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

output "etcd_0" {
  value = {
    "fqdn"  = module.etcd_0.fqdn,
    "alias" = module.etcd_0.alias,
    "ip"    = module.etcd_0.ip,
  }
}

output "etcd_1" {
  value = {
    "fqdn"  = module.etcd_1.fqdn,
    "alias" = module.etcd_1.alias,
    "ip"    = module.etcd_1.ip,
  }
}

output "etcd_2" {
  value = {
    "fqdn"  = module.etcd_2.fqdn,
    "alias" = module.etcd_2.alias,
    "ip"    = module.etcd_2.ip,
  }
}
