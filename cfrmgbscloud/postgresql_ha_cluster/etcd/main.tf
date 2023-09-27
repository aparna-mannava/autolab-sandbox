terraform {
  backend "s3" {}
}
 
locals {
  etcd_servers        = ["us01vlmbetcd01", "us01vlmbetcd02", "us01vlmbetcd03"]  # This is what you want to name (hostname) your etcd cluster nodes, should not exceed 15 chars limit
  etcd_hosts_p        = ["us01vlmbetcd01.auto.saas-n.com", "us01vlmbetcd02.auto.saas-n.com", "us01vlmbetcd03.auto.saas-n.com"]  # ETCD nodes with domain
  lob                 = "CFRM"
  bt_product          = "cfrm"
  bt_role             = "postgres"
  bt_server_mode      = "etcd"
  bt_tier             = "dev"
  bt_env              = "1"
  bt_customer         = "metro"
  bt_deployment_mode  = "green"
  owner               = "cfrmclouddevopsteam@bottomline.com"
  os_version          = "rhel8"
  environment         = "feature_CFRMCLOUD_3253_postgresql_ha_cluster"
  datacenter          = "ny2"
  cluster             = "ny2-azb-ntnx-08"
  network             = "ny2-autolab-app-ahv"
  hostgroup           = "BT ETCD for PostgreSQL Server"
  memory              = "2048"
  cpus                = "2"
  additional_disks = {
    1 = "25",
  }
  facts            = {
    bt_env                  = local.bt_env
    bt_tier                 = local.bt_tier
    bt_product              = local.bt_product
    bt_role                 = local.bt_role
    bt_lob                  = local.lob
    bt_customer             = local.bt_customer
    bt_etcd_cluster_members = local.etcd_hosts_p
  }
}
 
module "metro_autolab_pg_etcd_0" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.etcd_servers[0]}"
  alias               = "${local.bt_product}-${local.bt_customer}-${local.bt_tier}-${local.bt_server_mode}01-${local.facts.bt_deployment_mode}"
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  os_version          = local.os_version
  lob                 = local.lob
  owner               = local.owner
  cpus                = local.cpus
  memory              = local.memory
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter
  external_facts      = local.facts
  additional_disks    = local.additional_disks
}
 
 
module "metro_autolab_pg_etcd_1" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.etcd_servers[1]}"
  alias               = "${local.bt_product}-${local.bt_customer}-${local.bt_tier}-${local.bt_server_mode}02-${local.facts.bt_deployment_mode}"
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  os_version          = local.os_version
  lob                 = local.lob
  owner               = local.owner
  cpus                = local.cpus
  memory              = local.memory
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter
  external_facts      = local.facts
  additional_disks    = local.additional_disks
}
 
 
module "metro_autolab_pg_etcd_2" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.etcd_servers[2]}"
  alias               = "${local.bt_product}-${local.bt_customer}-${local.bt_tier}-${local.bt_server_mode}03-${local.facts.bt_deployment_mode}"
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  os_version          = local.os_version
  lob                 = local.lob
  owner               = local.owner
  cpus                = local.cpus
  memory              = local.memory
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter
  external_facts      = local.facts
  additional_disks    = local.additional_disks
}
 
 
output "metro_autolab_pg_etcd_0" {
  value = {
    "fqdn"  = module.metro_autolab_pg_etcd_0.fqdn
    "alias" = module.metro_autolab_pg_etcd_0.alias
    "ip"    = module.metro_autolab_pg_etcd_0.ip
  }
}
 
 
output "metro_autolab_pg_etcd_1" {
  value = {
    "fqdn"  = module.metro_autolab_pg_etcd_1.fqdn
    "alias" = module.metro_autolab_pg_etcd_1.alias
    "ip"    = module.metro_autolab_pg_etcd_1.ip
  }
}
output "metro_autolab_pg_etcd_2" {
  value = {
    "fqdn"  = module.metro_autolab_pg_etcd_2.fqdn
    "alias" = module.metro_autolab_pg_etcd_2.alias
    "ip"    = module.metro_autolab_pg_etcd_2.ip
  }
}