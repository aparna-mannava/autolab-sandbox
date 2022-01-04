terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vlpgetd221"]
  hapg_servers    = ["us01vlpgha222","us01vlpgha223","us01vlpgha224"]
  haproxy_server  = ["us01vlpgpx225"]
  backrest_server = ["us01vlpgbk226"]
  domain          = "auto.saas-n.com"
  tier            = "prod"
  bt_env          = "1"
  bt_product      = "dgb"
  bt_role         = "postgresql"
  lob             = "CLOUD"
  hostgroup       = "BT HA PG Server"
  environment     = "master"
  cluster         = "ny5-azc-ntnx-16"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  hapgfacts       = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_role"                 = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}","${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "cdbpgtest"
    "bt_pg_version"           = "12"
  }
  haproxyfacts    = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_role"                 = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}","${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "cdbgpgtest"
    "bt_pg_version"           = "12"
  }
}

module "ny2_cdb_hapg_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
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

module "ny2_cdb_hapg_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CEA-4699_add_csr_attributes"
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

module "ny2_cdb_hapg_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CEA-4699_add_csr_attributes"
  hostname             = "${local.hapg_servers[2]}"
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

module "ny2_cdb_haproxy_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
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

output "ny2_cdb_hapg_0" {
  value = {
    "fqdn"  = "${module.ny2_cdb_hapg_0.fqdn}",
    "alias" = "${module.ny2_cdb_hapg_0.alias}",
    "ip"    = "${module.ny2_cdb_hapg_0.ip}",
  }
}

output "ny2_cdb_hapg_1" {
  value = {
    "fqdn"  = "${module.ny2_cdb_hapg_1.fqdn}",
    "alias" = "${module.ny2_cdb_hapg_1.alias}",
    "ip"    = "${module.ny2_cdb_hapg_1.ip}",
  }
}

output "ny2_cdb_hapg_2" {
  value = {
    "fqdn"  = "${module.ny2_cdb_hapg_2.fqdn}",
    "alias" = "${module.ny2_cdb_hapg_2.alias}",
    "ip"    = "${module.ny2_cdb_hapg_2.ip}",
  }
}

output "ny2_cdb_haproxy_1" {
  value = {
    "fqdn"  = "${module.ny2_cdb_haproxy_1.fqdn}",
    "alias" = "${module.ny2_cdb_haproxy_1.alias}",
    "ip"    = "${module.ny2_cdb_haproxy_1.ip}",
  }
}
