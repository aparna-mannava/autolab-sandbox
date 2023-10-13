terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vletcd80"]
  hapg_servers    = ["us01vlhapg80","us01vlhapg81","us01vlhapg82"]
  haproxy_server  = ["us01vlpxy80"]
  backrest_server = ["us01vlbk80"]
  domain          = "auto.saas-n.com"
  tier            = "tst"
  bt_env          = "1"
  bt_product      = "cloud"
  bt_role		      = "pgbackrest"
  lob             = "CLOUD"
  hostgroup       = "BT PG Backrest Server"
  environment     = "feature_CLOUD_126964"
  cluster         = "ny5-aza-ntnx-14"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  facts           = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
	"bt_role"				  = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}","${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_pg_version"           = "16"
  }
}

module "us01vlbk80" {
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

output "us01vlbk80" {
  value = {
    "fqdn"  = "module.us01vlbk80.fqdn",
    "alias" = "module.us01vlbk80.alias",
    "ip"    = "module.us01vlbk80.ip",
  }
}