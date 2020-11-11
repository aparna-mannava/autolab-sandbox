terraform {
  backend "http" {}
} 

locals {
  etcd_servers    = ["us01vlcfrmrd601","us01vlcfrmrd602","us01vlcfrmrd603"]
  hapg_servers    = ["us01vlcfrmrd604","us01vlcfrmrd605","us01vlcfrmrd606"]
  haproxy_server  = ["us01vlcfrmrd600"]
  backrest_server = ["us01vlcfrmrd666"]
  etcd_hosts_p    = ["'us01vlcfrmrd601.auto.saas-n.com','us01vlcfrmrd602.auto.saas-n.com','us01vlcfrmrd603.auto.saas-n.com'"]
  backrest_alias  = ["cfrmrd-backrest"]
  domain          = "auto.saas-n.com"
  bt_product      = "cfrmrd"
  lob             = "CFRM"
  hostgroup       = "CFRMRD PG Backrest Server"
  environment     = "master"
  cluster         = "ny2-aza-ntnx-13"
  network         = "ny2-autolab-app-ahv"
  facts           = {
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "cfrmrd_cluster"
    "bt_pg_version"           = "12"
  }
}

module "cfrmrd_autolab_backrest_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.backrest_server[0]}"
  alias                = "${local.backrest_alias[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
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

output "cfrmrd_autolab_backrest_1" {
  value = {
    "fqdn"  = "${module.cfrmrd_autolab_backrest_1.fqdn}",
    "alias" = "${module.cfrmrd_autolab_backrest_1.alias}",
    "ip"    = "${module.cfrmrd_autolab_backrest_1.ip}",
  }
}
 