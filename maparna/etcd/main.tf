terraform {
  backend "s3" {}
}

locals {
<<<<<<< HEAD:aparna/etcd/main.tf
  etcd_servers    = ["us01vletcdts02"]
  etcd_hosts_p    = ["us01vletcdts02.auto.saas-n.com"]
  domain          = "auto.saas-n.com"
  tier            = "uat"
  bt_env          = "1"
=======
  etcd_servers    = ["us01vletcd151"]
  etcd_hosts_p    = ["us01vletcd151.auto.saas-n.com"]
  domain          = "auto.saas-n.com"
  tier            = "nonprod"
  bt_env          = "master"
>>>>>>> 9355441a114f9e0b9bdb76be1871a85e834e4ed3:maparna/etcd/main.tf
  lob             = "CLOUD"
  bt_product      = "fmcloud"
  bt_role         = "postgresql"
  hostgroup       = "BT ETCD for PostgreSQL Server"
  environment     = "master"
  cluster         = "ny5-aza-ntnx-14"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  facts           = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_role"                 = local.bt_role
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
  }
}

<<<<<<< HEAD:aparna/etcd/main.tf
module "us01vletcdts02" {
=======
module "us01vletcd151" {
>>>>>>> 9355441a114f9e0b9bdb76be1871a85e834e4ed3:maparna/etcd/main.tf
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
  }
}
<<<<<<< HEAD:aparna/etcd/main.tf


output "us01vletcdts02" {
  value = {
    "fqdn"  = "${module.us01vletcdts02.fqdn}",
    "alias" = "${module.us01vletcdts02.alias}",
    "ip"    = "${module.us01vletcdts02.ip}",
=======
output "us01vletcd151" {
  value = {
    "fqdn"  = "${module.us01vletcd151.fqdn}",
    "alias" = "${module.us01vletcd151.alias}",
    "ip"    = "${module.us01vletcd151.ip}",
>>>>>>> 9355441a114f9e0b9bdb76be1871a85e834e4ed3:maparna/etcd/main.tf
  }
}
