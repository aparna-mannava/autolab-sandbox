terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vldretcd01"]
  hapg_servers    = ["us01vldrhapg01","us01vldrhapg02"]
  haproxy_server  = ["us01vldrpx01"]
  backrest_server = ["us01vldrbk01"]
  domain          = "auto.saas-n.com"
  tier            = "nonprod"
  bt_env          = "pg_ny2test"
  bt_product      = "inf"
  bt_role         = "postgresql"
  lob             = "CLOUD"
  hostgroup       = "BT HA PG Server"
  environment     = "master"
  cluster         = "ny5-aza-ntnx-19"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  hapgfacts       = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_role"                 = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "pgclstrdmdr"
    "bt_pg_version"           = "15"
  }
  haproxyfacts    = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_role"                 = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "pgclstrdmdr"
    "bt_pg_version"           = "15"
  }
}

module "pgclstrdmdr_hapg_0" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  external_facts       = local.hapgfacts
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
    1 = "100",
    2 = "100",
  }
}

module "pgclstrdmdr_hapg_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[1]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  lob                  = local.lob
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.hapgfacts
  additional_disks     = {
    1 = "100",
    2 = "100",
  }
}

module "pgclstrdmdr_haproxy_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.haproxy_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT Patroni HA Proxy"
  foreman_environment  = local.environment
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.haproxyfacts
  datacenter           = local.datacenter
  lob                  = local.lob
  additional_disks     = {
    1 = "50",
    2 = "10",
  }
}

output "pgclstrdmdr_hapg_0" {
  value = {
    "fqdn"  = "${module.pgclstrdmdr_hapg_0.fqdn}",
    "alias" = "${module.pgclstrdmdr_hapg_0.alias}",
    "ip"    = "${module.pgclstrdmdr_hapg_0.ip}",
  }
}

output "pgclstrdmdr_hapg_1" {
  value = {
    "fqdn"  = "${module.pgclstrdmdr_hapg_1.fqdn}",
    "alias" = "${module.pgclstrdmdr_hapg_1.alias}",
    "ip"    = "${module.pgclstrdmdr_hapg_1.ip}",
  }
}

output "pgclstrdmdr_haproxy_1" {
  value = {
    "fqdn"  = "${module.pgclstrdmdr_haproxy_1.fqdn}",
    "alias" = "${module.pgclstrdmdr_haproxy_1.alias}",
    "ip"    = "${module.pgclstrdmdr_haproxy_1.ip}",
  }
}
