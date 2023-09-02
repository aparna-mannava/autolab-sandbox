terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vletcdtst92"]
  hapg_servers    = ["us01vlhapgtst92","us01vlhapgtst93","us01vlhapgtst94"]
  haproxy_server  = ["us01vlprxytst92"]
  backrest_server = ["us01vlbktst92"]
  domain          = "auto.saas-n.com"
  tier            = "nonprod"
  bt_env          = "1"
  bt_product      = "cloud"
  bt_role         = "postgresql"
  lob             = "CLOUD"
  hostgroup       = "BT HA PG Server"
  environment     = "production"
  cluster         = "ny5-aza-ntnx-14"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  hapgfacts       = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product 
    "bt_role"                 = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}", "${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
	  "bt_hapg_node3"           ="${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "us01vlhapgsep"
    "bt_pg_version"           = "12"
  }

  haproxyfacts = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_role"                 = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}", "${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
	  "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "us01vlhapgsep"
    "bt_pg_version"           = "12"
  }
}


module "us01vlhapgtst92" {
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

module "us01vlhapgtst93" {
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

module "us01vlhapgtst94" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[2]}"
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

module "us01vlprxytst92" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.haproxy_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT Patroni HA Proxy"
  foreman_environment  = local.environment
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.haproxyfacts
  datacenter           = local.datacenter
  lob                  = local.lob
  additional_disks     = {
    1 = "50",
    2 = "10",
  }
}

output "us01vlhapgtst92" {
  value = {
    "fqdn"  = "${module.us01vlhapgtst92.fqdn}",
    "alias" = "${module.us01vlhapgtst92.alias}",
    "ip"    = "${module.us01vlhapgtst92.ip}",
  }
}

output "us01vlhapgtst93" {
  value = {
    "fqdn"  = "${module.us01vlhapgtst93.fqdn}",
    "alias" = "${module.us01vlhapgtst93.alias}",
    "ip"    = "${module.us01vlhapgtst93.ip}",
  }
}

output "us01vlhapgtst94" {
  value = {
    "fqdn"  = "${module.us01vlhapgtst94.fqdn}",
    "alias" = "${module.us01vlhapgtst94.alias}",
    "ip"    = "${module.us01vlhapgtst94.ip}",
  }
}

output "us01vlprxytst92" {
  value = {
    "fqdn"  = "${module.us01vlprxytst92.fqdn}",
    "alias" = "${module.us01vlprxytst92.alias}",
    "ip"    = "${module.us01vlprxytst92.ip}",
  }
}