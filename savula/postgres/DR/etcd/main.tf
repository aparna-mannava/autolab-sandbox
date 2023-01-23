terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vldretcd01"]
  etcd_hosts_p    = ["us01vldretcd01.auto.saas-n.com"]
  domain          = "auto.saas-n.com"
  tier            = "nonprod"
  bt_env          = "pg_ny2test"
  lob             = "CLOUD"
  bt_product      = "inf"
  bt_role         = "postgresql"
  hostgroup       = "BT ETCD for PostgreSQL Server"
  environment     = "master"
  cluster         = "ny5-aza-ntnx-19"
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

module "pgclstrdmdr_etcd_0" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
  }
}
output "pgclstrdmdr_etcd_0" {
  value = {
    "fqdn"  = "${module.pgclstrdmdr_etcd_0.fqdn}",
    "alias" = "${module.pgclstrdmdr_etcd_0.alias}",
    "ip"    = "${module.pgclstrdmdr_etcd_0.ip}",
  }
}
