terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vletcd098","us01vletcd099"]
  hapg_servers    = ["us01vlhapg915","us01vlhapg916"]
  haproxy_server  = ["us01vlhapx915"]
  backrest_server = ["us01vlpgbk915"]
  etcd_hosts_p    = ["'us01vletcd098.auto.saas-n.com','us01vletcd099.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "sbx"
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
    "bt_cluster_name"         = "hapgnontde15"
    "bt_pg_version"           = "15"
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
    "bt_cluster_name"         = "hapgnontde15"
    "bt_pg_version"           = "15"
  }
  etcdfacts       = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}"]
  }
}

module "autolab_pg15nontde_hapg_1" {
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

module "autolab_pg15nontde_hapg_2" {
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

module "autolab_pg15nontde_hapx_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.haproxy_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT Patroni HA Proxy"
  foreman_environment  = local.environment
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "2048"
  external_facts       = local.haproxyfacts
  datacenter           = local.datacenter
  lob                  = local.lob
  additional_disks     = {
    1 = "50",
    2 = "10",
  }
}

output "autolab_pg15nontde_hapg_1" {
  value = {
    "fqdn"  = "${module.autolab_pg15nontde_hapg_1.fqdn}",
    "alias" = "${module.autolab_pg15nontde_hapg_1.alias}",
    "ip"    = "${module.autolab_pg15nontde_hapg_1.ip}",
  }
}

output "autolab_pg15nontde_hapg_2" {
  value = {
    "fqdn"  = "${module.autolab_pg15nontde_hapg_2.fqdn}",
    "alias" = "${module.autolab_pg15nontde_hapg_2.alias}",
    "ip"    = "${module.autolab_pg15nontde_hapg_2.ip}",
  }
}

output "autolab_pg15nontde_hapx_1" {
  value = {
    "fqdn"  = "${module.autolab_pg15nontde_hapx_1.fqdn}",
    "alias" = "${module.autolab_pg15nontde_hapx_1.alias}",
    "ip"    = "${module.autolab_pg15nontde_hapx_1.ip}",
  }
}
