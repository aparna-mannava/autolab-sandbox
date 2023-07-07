terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vletcdts90"]
  hapg_servers    = ["us01vlhapgts90","us01vlhapgts91","us01vlhapgts92"]
  haproxy_server  = ["us01vlprxyts90"]
  backrest_server = ["us01vlbkts90"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "db_hardened"
  bt_product      = "fmcloud"
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
    "bt_cluster_name"         = "us01vlhapgts"
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
    "bt_cluster_name"         = "us01vlhapgts"
    "bt_pg_version"           = "12"
  }
}


module "us01vlhapgts90" {
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

module "us01vlhapgts91" {
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

module "us01vlhapgts92" {
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

module "us01vlprxyts90" {
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

output "us01vlhapgts90" {
  value = {
    "fqdn"  = "${module.us01vlhapgts90.fqdn}",
    "alias" = "${module.us01vlhapgts90.alias}",
    "ip"    = "${module.us01vlhapgts90.ip}",
  }
}

output "us01vlhapgts91" {
  value = {
    "fqdn"  = "${module.us01vlhapgts91.fqdn}",
    "alias" = "${module.us01vlhapgts91.alias}",
    "ip"    = "${module.us01vlhapgts91.ip}",
  }
}

output "us01vlhapgts92" {
  value = {
    "fqdn"  = "${module.us01vlhapgts92.fqdn}",
    "alias" = "${module.us01vlhapgts92.alias}",
    "ip"    = "${module.us01vlhapgts92.ip}",
  }
}

output "us01vlprxyts90" {
  value = {
    "fqdn"  = "${module.us01vlprxyts90.fqdn}",
    "alias" = "${module.us01vlprxyts90.alias}",
    "ip"    = "${module.us01vlprxyts90.ip}",
  }
}