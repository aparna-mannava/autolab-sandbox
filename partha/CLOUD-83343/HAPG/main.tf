terraform {
  backend "http" {}
}


locals {
  etcd_servers    = ["us01vlhspetcd01","us01vlhspetcd02","us01vlhspetcd03"]
  hapg_servers    = ["us01vlhsphadb01","us01vlhsphadb02","us01vlhsphadb03"]
  haproxy_server  = ["us01vlhsppx01"]
  backrest_server = ["us01vlhspbk01"]
  etcd_hosts_p    = ["'us01vlhspetcd01.auto.saas-n.com','us01vlhspetcd02.auto.saas-n.com','us01vlhspetcd03.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "1"
  bt_product      = "inf"
  lob             = "CLOUD"
  hostgroup       = "BT HA PG Server"
  environment     = "master"
  cluster         = "ny2-aza-vmw-autolab"
  network         = "ny2-autolab-db"
  datacenter      = "ny2"
  facts           = {
    "bt_env"                  = "${local.bt_env}"
    "bt_tier"                 = "${local.tier}"
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}" , "${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "hspclstr"
    "bt_pg_version"           = "12"
  }
}

module "clr_83343_hapg_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  alias                = "us01hapg1"
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  external_facts       = local.facts
  additional_disks     = {
    1 = "100",
    2 = "100",
  }
}

module "clr_83343_hapg_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[1]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  lob                  = local.lob
  alias                = "us01hapg2"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  external_facts       = local.facts

  additional_disks     = {
    1 = "100",
    2 = "100",
  }
}

module "clr_83343_hapg_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[2]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  lob                  = local.lob
  alias                = "us01hapg3"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  external_facts       = local.facts
  additional_disks     = {
    1 = "100",
    2 = "100",
  }
}

module "clr_83343_haproxy_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.haproxy_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT Patroni HA Proxy"
  foreman_environment  = local.environment
  lob                  = local.lob
  alias                = "us01hsppxy"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "50",
    2 = "10",
  }
}

output "server_info" {
  value = <<INFO

||function||hostname||host alias||IP||
|db etz server|${module.clr_83343_hapg_1.fqdn}|${module.clr_83343_hapg_1.alias[0]}|${module.clr_83343_hapg_1.ip}|
|db ctz server|${module.clr_83343_hapg_2.fqdn}|${module.clr_83343_hapg_2.alias[0]}|${module.clr_83343_hapg_2.ip}|
|db ptz server|${module.clr_83343_hapg_3.fqdn}|${module.clr_83343_hapg_3.alias[0]}|${module.clr_83343_hapg_3.ip}|
|db agnt server|${module.clr_83343_haproxy_1.fqdn}|${module.clr_83343_haproxy_1.alias[0]}|${module.clr_83343_haproxy_1.ip}|
  INFO
}
