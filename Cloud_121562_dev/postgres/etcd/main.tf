terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vletcdts90"]
  etcd_hosts_p    = ["us01vletcdts90.auto.saas-n.com"]
  domain          = "auto.saas-n.com"
  tier            = "dev"
  bt_env          = "db_hardened"
  lob             = "FMCLOUD"
  bt_product      = "fmcloud"
  bt_role         = "postgres"
  hostgroup       = "BT ETCD for PostgreSQL Server"
  environment     = "production"
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

module "us01vletcdts90" {
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
  memory               = "2048"
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
  }
}


output "us01vletcdts90" {
  value = {
    "fqdn"  = "${module.us01vletcdts90.fqdn}",
    "alias" = "${module.us01vletcdts90.alias}",
    "ip"    = "${module.us01vletcdts90.ip}",
  }
}