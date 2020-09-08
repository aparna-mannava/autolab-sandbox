terraform {
  backend "http" {}
}

locals {
  etcd_servers    = ["us01vlbtiqed01","us01vlbtiqed02","us01vlbtiqed03"]
  hapg_servers    = ["us01vlbtiqpg01","us01vlbtiqpg02","us01vlbtiqpg03"]
  haproxy_server  = ["us01vlbtiqpxy1"]
  backrest_server = ["us01vlbtiqbkp1"]
  etcd_hosts_p    = ["'us01vlbtiqed01.auto.saas-n.com','us01vlbtiqed02.auto.saas-n.com','us01vlbtiqed03.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "5"
  bt_product      = "btiq"
  lob             = "btiq"
  hostgroup       = "BT PG Backrest Server"
  environment     = "master"
  cluster         = "ny2-azd-ntnx-10"
  network         = "ny2-autolab-db-ahv"
  facts           = {
    "bt_env"                  = "${local.bt_env}"
    "bt_tier"                 = "${local.tier}"
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}", "${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
  }
}

module "ny2_autolab_backrest_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.backrest_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT PG Backrest Server"
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
    2 = "500",
  }
}

output "ny2_autolab_backrest_1" {
  value = {
    "fqdn"  = "${module.ny2_autolab_backrest_1.fqdn}",
    "alias" = "${module.ny2_autolab_backrest_1.alias}",
    "ip"    = "${module.ny2_autolab_backrest_1.ip}",
  }
}
