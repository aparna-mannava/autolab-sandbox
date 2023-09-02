terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vltetcd151"]
  etcd_hosts_p    = ["us01vltetcd151.auto.saas-n.com"]
  domain          = "auto.saas-n.com"
  tier            = "production"
  bt_env          = "master"
  lob             = "CLOUD"
  bt_product      = "cloud"
  bt_role         = "postgres"
  hostgroup       = "BT ETCD for PostgreSQL Server"
  environment     = "master"
  cluster         = "ny2-aze-ntnx-12"
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

module "us01vltetcd151" {
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
output "us01vltetcd151" {
  value = {
    "fqdn"  = "${module.us01vltetcd151.fqdn}",
    "alias" = "${module.us01vltetcd151.alias}",
    "ip"    = "${module.us01vltetcd151.ip}",
  }
}