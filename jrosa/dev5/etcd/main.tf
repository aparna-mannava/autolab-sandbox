terraform {
  backend "http" {}
}

locals {
  etcd_servers    = ["us01vledsre001","us01vledsre002","us01vledsre003"]
  hapg_servers    = ["us01vlpgsre001","us01vlpgsre002","us01vlspgsre003"]
  haproxy_server  = ["us01vlhapxysre001"]
  backrest_server = ["us01vlbkpsre001"]
  etcd_hosts_p    = ["'us01vledsre001.auto.saas-n.com','us01vledsre002.auto.saas-n.com','us01vledsre003.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "5"
  bt_product      = "inf"
  lob             = "inf"
  hostgroup       = "BT ETCD for PostgreSQL Server"
  environment     = "nonprod"
  cluster         = "ny2-aza-ntnx-13"
  network         = "ny2-autolab-app-ahv"
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
    "bt_cluster_name"         = "watchtower_pg_dev"
    "bt_pg_version"           = "12"
  }
}

module "ny2_autolab_etcd_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

module "ny2_autolab_etcd_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[1]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

module "ny2_autolab_etcd_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[2]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  lob                  = local.lob
  foreman_environment  = local.environment
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

output "ny2_autolab_etcd_0" {
  value = {
    "fqdn"  = "${module.ny2_autolab_etcd_0.fqdn}",
    "alias" = "${module.ny2_autolab_etcd_0.alias}",
    "ip"    = "${module.ny2_autolab_etcd_0.ip}",
  }
}

output "ny2_autolab_etcd_1" {
  value = {
    "fqdn"  = "${module.ny2_autolab_etcd_1.fqdn}",
    "alias" = "${module.ny2_autolab_etcd_1.alias}",
    "ip"    = "${module.ny2_autolab_etcd_1.ip}",
  }
}

output "ny2_autolab_etcd_2" {
  value = {
    "fqdn"  = "${module.ny2_autolab_etcd_2.fqdn}",
    "alias" = "${module.ny2_autolab_etcd_2.alias}",
    "ip"    = "${module.ny2_autolab_etcd_2.ip}",
  }
}