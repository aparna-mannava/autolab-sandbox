terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vletcd098","us01vletcd099"]
  hapg_servers    = ["us01vlhapg098","us01vlhapg099"]
  haproxy_server  = ["us01vlhapx098"]
  backrest_server = ["us01vlpgbk098"]
  etcd_hosts_p    = ["'us01vletcd098.auto.saas-n.com','us01vletcd099.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "ppd"
  bt_env          = "9"
  bt_product      = "ir"
  bt_role         = "postgresql"
  lob             = "CLOUD"
  hostgroup       = "BT HA PG Server"
  environment     = "master"
  cluster         = "ny2-azb-ntnx-08"
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
    "bt_cluster_name"         = "hapgnontde14"
    "bt_pg_version"           = "14"
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
    "bt_cluster_name"         = "hapgnontde14"
    "bt_pg_version"           = "14"
  }
  etcdfacts       = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}"]
  }
}

module "autolab_pg14nontde_backrest_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.backrest_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT PG Backrest Server"
  external_facts       = local.hapgfacts
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  lob                  = local.lob
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
    1 = "100",
    2 = "160",
  }
}
output "autolab_pg14nontde_backrest_1" {
  value = {
    "fqdn"  = "${module.autolab_pg14nontde_backrest_1.fqdn}",
    "alias" = "${module.autolab_pg14nontde_backrest_1.alias}",
    "ip"    = "${module.autolab_pg14nontde_backrest_1.ip}",
  }
}
