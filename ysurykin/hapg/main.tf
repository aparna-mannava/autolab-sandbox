terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vlsndbxd11","us01vlsndbxd12","us01vlsndbxd13"]
  hapg_servers    = ["us01vlsndbpg11","us01vlsndbpg12","us01vlsndbpg13"]
  haproxy_server  = ["us01vlsndbpxy1"]
  backrest_server = ["us01vllkp1"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "1"
  bt_product      = "pmx"
  lob             = "PBS"
  hostgroup       = "BT PMX HA PG for PostgreSQL Server"
  environment     = "feature_PXDVOP_24317"
  cluster         = "ny5-aza-ntnx-19"
  network         = "ny2-autolab-db-ahv"
  fw_group        = "PMX_QA_63_DB"
  facts = {
    "bt_env"                  = "${local.bt_env}"
    "bt_tier"                 = "${local.tier}"
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}", "${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_pg_version"           = "12"
    "bt_cluster_name"         = "pmx-o2p"
  }
}

module "ny2_autolab_hapg_0" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = local.hapg_servers[0]
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  lob                 = local.lob
  foreman_hostgroup   = local.hostgroup
  foreman_environment = local.environment
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "4096"
  external_facts      = local.facts
  datacenter          = "ny2"
  additional_disks = {
    1 = "100",
    2 = "150",
    3 = "150",
  }
}

module "ny2_autolab_hapg_1" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = local.hapg_servers[1]
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  foreman_hostgroup   = local.hostgroup
  foreman_environment = local.environment
  lob                 = local.lob
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "4096"
  external_facts      = local.facts
  datacenter          = "ny2"
  additional_disks = {
    1 = "100",
    2 = "150",
    3 = "150",
  }
}

module "ny2_autolab_hapg_2" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = local.hapg_servers[2]
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  foreman_hostgroup   = local.hostgroup
  foreman_environment = local.environment
  lob                 = local.lob
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "4096"
  external_facts      = local.facts
  datacenter          = "ny2"
  additional_disks = {
    1 = "100",
    2 = "150",
    3 = "150",
  }
}

module "ny2_autolab_haproxy_1" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = local.haproxy_server[0]
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  foreman_hostgroup   = "BT Patroni HA Proxy"
  foreman_environment = local.environment
  lob                 = local.lob
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "4096"
  external_facts      = local.facts
  datacenter          = "ny2"
  additional_disks = {
    1 = "50",
    2 = "10",
  }
}

output "ny2_autolab_hapg_0" {
  value = {
    "fqdn"  = "${module.ny2_autolab_hapg_0.fqdn}",
    "alias" = "${module.ny2_autolab_hapg_0.alias}",
    "ip"    = "${module.ny2_autolab_hapg_0.ip}",
  }
}

output "ny2_autolab_hapg_1" {
  value = {
    "fqdn"  = "${module.ny2_autolab_hapg_1.fqdn}",
    "alias" = "${module.ny2_autolab_hapg_1.alias}",
    "ip"    = "${module.ny2_autolab_hapg_1.ip}",
  }
}

output "ny2_autolab_hapg_2" {
  value = {
    "fqdn"  = "${module.ny2_autolab_hapg_2.fqdn}",
    "alias" = "${module.ny2_autolab_hapg_2.alias}",
    "ip"    = "${module.ny2_autolab_hapg_2.ip}",
  }
}

output "ny2_autolab_haproxy_1" {
  value = {
    "fqdn"  = "${module.ny2_autolab_haproxy_1.fqdn}",
    "alias" = "${module.ny2_autolab_haproxy_1.alias}",
    "ip"    = "${module.ny2_autolab_haproxy_1.ip}",
  }
}