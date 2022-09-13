terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vlletc001", "us01vlletc002", "us01vlletc003"]
  hapg_servers    = ["us01vllpg1", "us01vllpg2", "us01vllpg3"]
  haproxy_server  = ["us01vllpxy1"]
  backrest_server = ["us01vllkp1"]
  etcd_hosts_p    = ["'us01vllect001.auto.saas-n.com','us01vllect002.auto.saas-n.com','us01vllect.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "1"
  bt_product      = "cea"
  lob             = "CEA"
  hostgroup       = "BT ETCD for PostgreSQL Server"
  environment     = "master"
  cluster         = "ny2-azd-ntnx-10"
  network         = "ny2-autolab-db-ahv"
  facts = {
    "bt_env"                  = "${local.bt_env}"
    "bt_tier"                 = "${local.tier}"
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}", "${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "tlstest1"
  }
}

module "ny2_autolab_backrest_1" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = local.backrest_server[0]
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  foreman_hostgroup   = "BT PG Backrest Server"
  foreman_environment = local.environment
  lob                 = local.lob
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "4096"
  external_facts      = local.facts
  datacenter          = "ny2"
  additional_disks = {
    1 = "100",
    2 = "400",
  }
}

output "ny2_autolab_backrest_1" {
  value = {
    "fqdn"  = "${module.ny2_autolab_backrest_1.fqdn}",
    "alias" = "${module.ny2_autolab_backrest_1.alias}",
    "ip"    = "${module.ny2_autolab_backrest_1.ip}",
  }
}
