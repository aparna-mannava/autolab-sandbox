terraform {
  backend "s3" {}
}

locals {
  # comments
  etcd_servers    = ["us01vltfetcd11","us01vltfetcd12","us01vltfetcd13"]
  hapg_servers    = ["us01vltfhapg11","us01vltfhapg12","us01vltfhapg13"]
  backrest_server = ["us01vltfpgbkp11"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "11"
  bt_product      = "fmcloud"
  lob             = "fmcloud"
  hostgroup       = "BT HA PG Server"
  environment     = "master"
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
