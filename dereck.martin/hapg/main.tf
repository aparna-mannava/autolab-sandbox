terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vldved991","us01vldved992","us01vldved993"]
  hapg_servers    = ["us01vldvpg991","us01vldvpg992","us01vldvpg993"]
  haproxy_servers = ["us01vldvpxy991", "us01vldvpxy992"]
  backrest_server = ["us01vldvbkp991"]
  etcd_hosts_p    = ["'us01vldved001.auto.saas-n.com','us01vldved002.auto.saas-n.com','us01vldved003.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "5"
  bt_product      = "pbscap"
  lob             = "PBS"
  hostgroup       = "BT HA PG Server"
  environment     = "feature_CEA_9822"
  cluster         = "ny2-aze-ntnx-12"
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
    "bt_hapg_haproxy_servers" = ["${local.haproxy_servers[0]}.${local.domain}", "${local.haproxy_servers[1]}.${local.domain}"]
    "bt_hapg_haproxy_service" = "hapg9999.auto.saas-n.com"
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
  2 = "150",
  3 = "150",
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
  2 = "150",
  3 = "150",
  }
}

module "ny2_autolab_hapg_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[2]}"
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
    2 = "150",
    3 = "150",
  }
}

module "ny2_autolab_haproxy_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.haproxy_servers[0]}"
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

module "ny2_autolab_haproxy_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.haproxy_servers[1]}"
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

resource "infoblox_record_host" "hapg9999" {
  name              = "hapg9999.auto.saas-n.com"
  configure_for_dns = true
  ipv4addr {
    function           = "func:nextavailableip:10.226.190.0/24"
    configure_for_dhcp = false
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

output "ny2_autolab_hapg_2" {
  value = {
    "fqdn"  = "${module.ny2_autolab_hapg_2.fqdn}",
    "alias" = "${module.ny2_autolab_hapg_2.alias}",
    "ip"    = "${module.ny2_autolab_hapg_2.ip}",
  }
}

output "ny2_autolab_haproxy_1" {
  value = {
    "fqdn"  = "${module.ny2_autolab_haproxy_1.fqdn}",
    "alias" = "${module.ny2_autolab_haproxy_1.alias}",
    "ip"    = "${module.ny2_autolab_haproxy_1.ip}",
  }
}

output "ny2_autolab_haproxy_2" {
  value = {
    "fqdn"  = "${module.ny2_autolab_haproxy_2.fqdn}",
    "alias" = "${module.ny2_autolab_haproxy_2.alias}",
    "ip"    = "${module.ny2_autolab_haproxy_2.ip}",
  }
}