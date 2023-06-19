terraform {
    backend "s3" {}
  }

  locals {
    etcd_servers    = ["us01vltfet04","us01vltfet05"]
    hapg_servers    = ["us01vltfpg04","us01vltfpg05"]
    haproxy_server  = ["us01vltfpx04"]
    backrest_server = ["us01vltfbk04"]
    etcd_hosts_p    = ["'us01vltfet04.auto.saas-n.com','us01vltfet05.auto.saas-n.com'"]
    domain          = "auto.saas-n.com"
    tier            = "dev"
    bt_env          = "1"
    bt_product      = "cloud"
    bt_role         = "postgresql"
    lob             = "CLOUD"
    hostgroup       = "BT ETCD for PostgreSQL Server"
    environment     = "master"
    cluster         = "ny5-aza-ntnx-14"
    network         = "ny2-autolab-app-ahv"
    datacenter      = "ny2"
    hapgfacts       = {
      "bt_env"                  = local.bt_env
      "bt_tier"                 = local.tier
      "bt_product"              = local.bt_product
      "bt_role"                 = local.bt_role
      "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}"]
      "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
      "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
      "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
      "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
      "bt_cluster_name"         = "hatfpg12"
      "bt_pg_version"           = "12"
    }
    haproxyfacts    = {
      "bt_env"                  = local.bt_env
      "bt_tier"                 = local.tier
      "bt_product"              = local.bt_product
      "bt_role"                 = local.bt_role
      "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}"]
      "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
      "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
      "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
      "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
      "bt_cluster_name"         = "hatfpg12"
      "bt_pg_version"           = "12"
    }
    facts           = {
      "bt_env"                  = local.bt_env
      "bt_tier"                 = local.tier
      "bt_product"              = local.bt_product
      "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}"]
    }
  }

  module "ny2_cdb_etcd_0" {
    source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
    hostname             = "${local.etcd_servers[0]}"
    bt_infra_cluster     = local.cluster
    bt_infra_network     = local.network
    lob                  = local.lob
    foreman_hostgroup    = local.hostgroup
    foreman_environment  = local.environment
    datacenter           = local.datacenter
    os_version           = "rhel8"
    cpus                 = "2"
    memory               = "4096"
    external_facts       = local.facts
    additional_disks     = {
      1 = "200",
    }
  }

  module "ny2_cdb_etcd_1" {
    source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
    hostname             = "${local.etcd_servers[1]}"
    bt_infra_cluster     = local.cluster
    bt_infra_network     = local.network
    lob                  = local.lob
    foreman_hostgroup    = local.hostgroup
    foreman_environment  = local.environment
    datacenter           = local.datacenter
    os_version           = "rhel8"
    cpus                 = "2"
    memory               = "4096"
    external_facts       = local.facts
    additional_disks     = {
      1 = "200",
    }
  }

  output "ny2_cdb_etcd_0" {
    value = {
      "fqdn"  = "${module.ny2_cdb_etcd_0.fqdn}",
      "alias" = "${module.ny2_cdb_etcd_0.alias}",
      "ip"    = "${module.ny2_cdb_etcd_0.ip}",
    }
  }

  output "ny2_cdb_etcd_1" {
    value = {
      "fqdn"  = "${module.ny2_cdb_etcd_1.fqdn}",
      "alias" = "${module.ny2_cdb_etcd_1.alias}",
      "ip"    = "${module.ny2_cdb_etcd_1.ip}",
    }
  }
