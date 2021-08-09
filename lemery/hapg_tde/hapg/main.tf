terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vllabed77"]
  hapg_servers    = ["us01vllabpg77","us01vllabpg78"]
  haproxy_server  = ["us01vllabpx77"]
  backrest_server = ["us01vllabbk77"]
  domain          = "auto.saas-n.com"
  tier            = "auto"
  bt_env          = "1"
  bt_product      = "btiq"
  lob             = "CEA"
  hostgroup       = "BT HA PG Server"
  environment     = "feature_CEA_4699_TDE_cont"
  cluster         = "ny5-azc-ntnx-16"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  hapgfacts       = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_role"                 = "postgresql"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "laepattest"
    "bt_pg_version"           = "12"
  }
  haproxyfacts    = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "laepattest"
    "bt_pg_version"           = "12"
  }
}

module "auto_lae_hapg_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CEA-4699_add_csr_attributes"
  hostname             = "${local.hapg_servers[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.hapgfacts
  additional_disks     = {
    1 = "100",
    2 = "100",
  }
}

module "auto_lae_hapg_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CEA-4699_add_csr_attributes"
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

module "auto_lae_haproxy_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CEA-4699_add_csr_attributes"
  hostname             = "${local.haproxy_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT Patroni HA Proxy"
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.haproxyfacts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "50",
    2 = "10",
  }
}

output "auto_lae_hapg_0" {
  value = {
    "fqdn"  = "${module.auto_lae_hapg_0.fqdn}",
    "alias" = "${module.auto_lae_hapg_0.alias}",
    "ip"    = "${module.auto_lae_hapg_0.ip}",
  }
}

output "auto_lae_hapg_1" {
  value = {
    "fqdn"  = "${module.auto_lae_hapg_1.fqdn}",
    "alias" = "${module.auto_lae_hapg_1.alias}",
    "ip"    = "${module.auto_lae_hapg_1.ip}",
  }
}

output "auto_lae_haproxy_1" {
  value = {
    "fqdn"  = "${module.auto_lae_haproxy_1.fqdn}",
    "alias" = "${module.auto_lae_haproxy_1.alias}",
    "ip"    = "${module.auto_lae_haproxy_1.ip}",
  }
}
