terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vllabed99"]
  hapg_servers    = ["us01vllabpg98","us01vllabpg99"]
  haproxy_server  = ["us01vllabpx99"]
  backrest_server = ["us01vllabbk99"]
  domain          = "auto.saas-n.com"
  tier            = "auto"
  bt_env          = "1"
  bt_product      = "btiq"
  lob             = "CEA"
  hostgroup       = "BT PG Backrest Server"
  environment     = "master"
  cluster         = "ny5-azc-ntnx-16"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  facts           = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_pg_version"           = "12"
  }
}

module "auto_lae_backrest_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.backrest_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT PG Backrest Server"
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  additional_disks     = {
    1 = "100",
    2 = "160",
  }
}

output "auto_lae_backrest_1" {
  value = {
    "fqdn"  = "${module.auto_lae_backrest_1.fqdn}",
    "alias" = "${module.auto_lae_backrest_1.alias}",
    "ip"    = "${module.auto_lae_backrest_1.ip}",
  }
}
