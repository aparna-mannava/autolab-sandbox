terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["gb03vlbk01"]
  hapg_servers    = ["gb03vlhapgaug01","gb03vlhapgaug02","gb03vlhapgaug03"]
  haproxy_server  = ["gb03vlprxy01"]
  backrest_server = ["gb03vlbk01"]
  domain          = "auto.saas-n.com"
  tier            = "dv"
  bt_env          = "1"
  bt_product      = fmlsaas"
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
module "gb03vlbk01" {
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
output "gb03vlbk01" {
  value = {
    "fqdn"  = "${module.gb03vlbk01.fqdn}",
    "alias" = "${module.gb03vlbk01.alias}",
    "ip"    = "${module.gb03vlbk01.ip}",
  }
}
# modified
