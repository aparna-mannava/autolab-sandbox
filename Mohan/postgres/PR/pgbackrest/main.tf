terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vlmretcd01"]
  hapg_servers    = ["us01vlmrhapg01","us01vlmrhapg02"]
  haproxy_server  = ["us01vlmrpx01"]
  backrest_server = ["us01vlmrbk01"]
  domain          = "auto.saas-n.com"
  tier            = "nonprod"
  bt_env          = "pg_ny2test"
  bt_product      = "inf"
  bt_role		      = "pgbackrest"
  lob             = "CLOUD"
  hostgroup       = "BT PG Backrest Server"
  environment     = "master"
  cluster         = "ny5-aza-ntnx-19"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  facts           = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
	  "bt_role"				          = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_pg_version"           = "15"
  }
}

module "pgclstrmr1_backrest_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.backrest_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT PG Backrest Server"
  external_facts       = local.facts
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

output "pgclstrmr1_backrest_1" {
  value = {
    "fqdn"  = "module.pgclstrmr1_backrest_1.fqdn",
    "alias" = "module.pgclstrmr1_backrest_1.alias",
    "ip"    = "module.pgclstrmr1_backrest_1.ip",
  }
}
