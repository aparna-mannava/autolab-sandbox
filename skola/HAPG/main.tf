terraform {
  backend "http" {}
}


locals {
  etcd_servers    = ["us01vlpeacd01","us01vlpeacd02","us01vlpeacd03"]
  hapg_servers    = ["us01vlssgdb01","us01vlssgdb02","us01vlssgdb03"]
  haproxy_server  = ["us01vlssx01"]
  backrest_server = ["us01vlsbk01"]
  etcd_hosts_p    = ["'us01vlpeacd01.auto.saas-n.com','us01vlpeacd01.auto.saas-n.com','us01vlpeacd03.auto.saas-n.com'"]
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
    "bt_cluster_name"         = "pclstr"
    "bt_pg_version"           = "12"
  }
}

module "ny2_myclstr_hapg_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
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

module "ny2_myclstr_hapg_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[1]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  external_facts       = local.facts

  additional_disks     = {
    1 = "100",
    2 = "100",
  }
}

module "ny2_myclstr_hapg_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[2]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  external_facts       = local.facts
  additional_disks     = {
    1 = "100",
    2 = "100",
  }
}

module "ny2_myclstr_haproxy_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.haproxy_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT Patroni HA Proxy"
  foreman_environment  = local.environment
  lob                  = local.lob
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

output "ny2_myclstr_hapg_0" {
  value = {
    "fqdn"  = "${module.ny2_myclstr_hapg_0.fqdn}",
    "alias" = "${module.ny2_myclstr_hapg_0.alias}",
    "ip"    = "${module.ny2_myclstr_hapg_0.ip}",
  }
}

output "ny2_myclstr_hapg_1" {
  value = {
    "fqdn"  = "${module.ny2_myclstr_hapg_1.fqdn}",
    "alias" = "${module.ny2_myclstr_hapg_1.alias}",
    "ip"    = "${module.ny2_myclstr_hapg_1.ip}",
  }
}

output "ny2_myclstr_hapg_2" {
  value = {
    "fqdn"  = "${module.ny2_myclstr_hapg_2.fqdn}",
    "alias" = "${module.ny2_myclstr_hapg_2.alias}",
    "ip"    = "${module.ny2_myclstr_hapg_2.ip}",
  }
}
output "ny2_myclstr_haproxy_1" {
  value = {
    "fqdn"  = "${module.ny2_myclstr_haproxy_1.fqdn}",
    "alias" = "${module.ny2_myclstr_haproxy_1.alias}",
    "ip"    = "${module.ny2_myclstr_haproxy_1.ip}",
  }
}
