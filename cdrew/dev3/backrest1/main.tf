terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vldved001","us01vldved002","us01vldved003"]
  hapg_servers    = ["us01vldvpg1","us01vldvpg2","us01vldvpg3"]
  haproxy_server  = ["us01vldvpxy1"]
  backrest_server = ["us01vldvbkp2"]
  etcd_hosts_p    = ["'us01vldved001.auto.saas-n.com','us01vldved002.auto.saas-n.com','us01vldved003.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "6"
  bt_product      = "pbscap"
  lob             = "pbs"
  hostgroup       = "BT PG Backrest Server"
  environment     = "feature_CEA_9335"
  cluster         = "ny5-aza-ntnx-14"
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
  }
}

module "ny2_autolab_backrest_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.backrest_server[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT PG Backrest Server"
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
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
