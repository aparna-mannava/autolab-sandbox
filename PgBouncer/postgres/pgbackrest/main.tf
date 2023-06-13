terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vletcdpgb20"]
  hapg_servers    = ["us01vlhapgpgb21","us01vlhapgpgb22","us01vlhapgpgb23"]
  haproxy_server  = ["us01vlprxypgb20"]
  backrest_server = ["us01vlbkpgb20"]
  domain          = "auto.saas-n.com"
  tier            = "nonpod"
  bt_env          = "1"
  bt_product      = "cloud"
  bt_role		      = "pgbackrest"
  lob             = "CLOUD"
  hostgroup       = "BT PG Backrest Server"
  environment     = "production"
  cluster         = "ny5-aza-ntnx-14"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  facts           = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
	  "bt_role"				          = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}","${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_pg_version"           = "12" 
  }
}
module "us01vlbkpgb20" {
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
output "us01vlbkpgb20" {
  value = {
    "fqdn"  = "${module.us01vlbkpgb20.fqdn}",
    "alias" = "${module.us01vlbkpgb20.alias}",
    "ip"    = "${module.us01vlbkpgb20.ip}",
  }
}