terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vliqaued01","us01vliqaued02","us01vliqaued03"]
  hapg_servers    = ["us01vliqaupg01","us01vliqaupg02","us01vliqaupg03"]
  haproxy_server  = ["us01vliqaupxy1"]
  backrest_server = ["us01vliqaubkp1"]
  etcd_hosts_p    = ["'us01vliqaued01.auto.saas-n.com','us01vliqaued02.auto.saas-n.com','us01vliqaued03.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "auto"
  bt_env          = "2"
  bt_product      = "btiq"
  lob             = "btiq"
  hostgroup       = "BT HA PG Server"
  environment     = "master"
  cluster         = "us-01-vn-nutanix09"
  network         = "ny2-autolab-db-ahv"
  facts           = {
    "bt_env"                  = "${local.bt_env}"
    "bt_tier"                 = "${local.tier}"
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "labhacluster"
    "bt_pg_version"           = "12"
  }
}

module "ny2_autolab_hapg_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = "BT HA PG Server"
  foreman_environment  = local.environment
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
  1 = "100",
  2 = "50",
  }
}

module "ny2_autolab_hapg_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[1]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT HA PG Server"
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
  1 = "100",
  2 = "50",
  }
}

module "ny2_autolab_haproxy_1" {
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
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
    2 = "10",
  }
}

output "ny2_autolab_hapg_0" {
  value = {
    "fqdn"  = "${module.ny2_autolab_hapg_0.fqdn}",
    "alias" = "${module.ny2_autolab_hapg_0.alias}",
    "ip"    = "${module.ny2_autolab_hapg_0.ip}",
  }
}

output "ny2_autolab_hapg_1" {
  value = {
    "fqdn"  = "${module.ny2_autolab_hapg_1.fqdn}",
    "alias" = "${module.ny2_autolab_hapg_1.alias}",
    "ip"    = "${module.ny2_autolab_hapg_1.ip}",
  }
}

output "ny2_autolab_haproxy_1" {
  value = {
    "fqdn"  = "${module.ny2_autolab_haproxy_1.fqdn}",
    "alias" = "${module.ny2_autolab_haproxy_1.alias}",
    "ip"    = "${module.ny2_autolab_haproxy_1.ip}",
  }
}