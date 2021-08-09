terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["us01vllabed77"]
  etcd_hosts_p    = ["'us01vllabed77.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "auto"
  bt_env          = "1"
  lob             = "CEA"
  bt_product      = "btiq"
  hostgroup       = "BT ETCD for PostgreSQL Server"
  environment     = "feature_CEA_4699_TDE_cont"
  cluster         = "ny5-azc-ntnx-16"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  facts           = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}"]
  }
}

module "auto_lae_etcd_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CEA-4699_add_csr_attributes"
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



output "auto_lae_etcd_0" {
  value = {
    "fqdn"  = "${module.auto_lae_etcd_0.fqdn}",
    "alias" = "${module.auto_lae_etcd_0.alias}",
    "ip"    = "${module.auto_lae_etcd_0.ip}",
  }
}
