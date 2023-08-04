terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["gb03vletcd01"]
  etcd_hosts_p    = ["gb03vletcd01.auto.saas-n.com"]
  domain          = "auto.saas-n.com"
  tier            = "dv"
  bt_env          = "1"
  lob             = "CLOUD"
  bt_product      = "fmlsaas"
  bt_role         = "postgres"
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

module "gb03vletcd01" {
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


output "gb03vletcd01" {
  value = {
    "fqdn"  = "${module.gb03vletcd01.fqdn}",
    "alias" = "${module.gb03vletcd01.alias}",
    "ip"    = "${module.gb03vletcd01.ip}",
  }
}
