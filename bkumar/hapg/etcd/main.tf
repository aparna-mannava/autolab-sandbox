terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vlbtiqed01","us01vlbtiqed02","us01vlbtiqed03"]
  etcd_hosts_p    = ["'us01vlbtiqed01.auto.saas-n.com','us01vlbtiqed02.auto.saas-n.com','us01vlbtiqed03.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "1"
  bt_product      = "btiq"
  lob             = "btiq"
  hostgroup       = "BT ETCD for PostgreSQL Server"
  environment     = "master"
  cluster         = "ny2-aza-ntnx-07"
  network         = "ny2-autolab-app-ahv"
  facts           = {
    "bt_env"                  = "${local.bt_env}"
    "bt_tier"                 = "${local.tier}"
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
  }
}

module "ny2_btiq_etcd_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "2048"
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
  }
}

module "ny2_btiq_etcd_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[1]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "2048"
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
  }
}

module "ny2_btiq_etcd_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[2]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  lob                  = local.lob
  foreman_environment  = local.environment
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "2048"
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
  }
}

output "ny2_btiq_etcd_0" {
  value = {
    "fqdn"  = "${module.ny2_btiq_etcd_0.fqdn}",
    "alias" = "${module.ny2_btiq_etcd_0.alias}",
    "ip"    = "${module.ny2_btiq_etcd_0.ip}",
  }
}

output "ny2_btiq_etcd_1" {
  value = {
    "fqdn"  = "${module.ny2_btiq_etcd_1.fqdn}",
    "alias" = "${module.ny2_btiq_etcd_1.alias}",
    "ip"    = "${module.ny2_btiq_etcd_1.ip}",
  }
}

output "ny2_btiq_etcd_2" {
  value = {
    "fqdn"  = "${module.ny2_btiq_etcd_2.fqdn}",
    "alias" = "${module.ny2_btiq_etcd_2.alias}",
    "ip"    = "${module.ny2_btiq_etcd_2.ip}",
  }
}
