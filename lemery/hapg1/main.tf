terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vletcdle01","us01vletcdle02","us01vletcdle03"]
  hapg_servers    = ["us01vlpgle01","us01vlpgle02","us01vlpgle03"]
  haproxy_servers  = ["us01vlhapxle01","us01vlhapxle02"]
  backrest_server = ["us01vlbkple01"]
  etcd_hosts_p    = ["'us01vletcdle01.auto.saas-n.com','us01vletcdle02.auto.saas-n.com','us01vletcdle03.auto.saas-n.com'"]
  os              = "rhel7"
  domain          = "auto.saas-n.com"
  datacenter      = "ny2"
  tier            = "prd"
  bt_env          = "1"
  bt_product      = "fmlsaas"
  lob             = "FML"
  environment     = "master"
  cluster         = "ny5-azc-ntnx-16"
  network         = "ny2-autolab-app-ahv"
  etcd_hostgroup  = "BT ETCD for PostgreSQL Server"
  pg_datacenter   = "ny2"
  pg_tier         = "prd"
  bt_cluster_name = "le-test"
  pg_hostgroup    = "BT HA PG Server"
  hapxy_hostgroup = "BT Patroni HA Proxy"
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
    "bt_hapg_haproxy_servers" = ["${local.haproxy_servers[0]}.${local.domain}", "${local.haproxy_servers[1]}.${local.domain}"]
    "bt_hapg_haproxy_service" = "hapg1911.auto.saas-n.com"
  }
}

module "pg_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.hapg_servers[0]
  alias                = "le-${local.pg_datacenter}-${local.pg_tier}-pg1"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.pg_hostgroup
  foreman_environment  = local.environment
  os_version           = local.os
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
    2 = "150",
    3 = "150",
  }
}

module "pg_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.hapg_servers[1]
  alias                = "le-${local.pg_datacenter}-${local.pg_tier}-pg2"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.pg_hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = local.os
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
    2 = "150",
    3 = "150",
  }
}

module "pg_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.hapg_servers[2]
  alias                = "le-${local.pg_datacenter}-${local.pg_tier}-pg3"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.pg_hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = local.os
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
    2 = "150",
    3 = "150",
  }
}

module "haproxy_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.haproxy_servers[0]
  alias                = "le-${local.pg_datacenter}-${local.pg_tier}-haproxy1"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hapxy_hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = local.os
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "50",
    2 = "10",
  }
}

module "haproxy_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.haproxy_servers[1]
  alias                = "le-${local.pg_datacenter}-${local.pg_tier}-haproxy2"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hapxy_hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = local.os
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "50",
    2 = "10",
  }
}

# resource "infoblox_record_host" "hapg1911" {
#   name              = "hapg1911.auto.saas-n.com"
#   configure_for_dns = true
#   ipv4addr {
#     function           = "func:nextavailableip:10.226.190.0/24"
#     configure_for_dhcp = false
#   }
# }


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


output "haproxy_1" {
  value = {
    "fqdn"  = module.haproxy_1.fqdn,
    "alias" = module.haproxy_1.alias,
    "ip"    = module.haproxy_1.ip,
  }
}
