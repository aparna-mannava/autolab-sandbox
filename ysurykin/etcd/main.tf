terraform {
  backend "s3" {}
}

locals {
  bt_product      = "pmx"
  lob             = "PBS"
  tier            = "dev"
  bt_env          = "1"
  domain          = "auto.saas-n.com"
  environment     = "master"
  datacenter      = "ny2"
  db_env          = "ny2-autolab-app-ahv"
  cluster         = "ny5-aza-ntnx-19"
  hostgroup       = "feature_PXDVOP-24317_etcd"
  etcd_servers    = ["us01vlsndbxd11","us01vlsndbxd12","us01vlsndbxd13"]
  hapg_servers    = ["us01vlsndbpg11","us01vlsndbpg12","us01vlsndbpg13"]
  haproxy_server  = ["us01vlsndbpxy1"]
  backrest_server = ["us01vllkp1"]
  fw_group        = "PMX_QA_63_DB"
  facts           = {
    "bt_env"                  = "${local.bt_env}"
    "bt_tier"                 = "${local.tier}"
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_pg_version"           = "12"
    "bt_cluster_name"         = "pmx-o2p"
 #   "bt_override_date"        = "2023-03-01"
  }
}

module "pmx_etcd_0" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.etcd_servers[0]
  alias                = "${local.bt_product}-${local.tier}${local.bt_env}-etcd01"
  bt_infra_network     = local.db_env
  bt_infra_cluster     = local.cluster
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
  }
}

output "pmx_etcd_0" {
  value = {
    "fqdn"  = module.pmx_etcd_0.fqdn,
    "alias" = module.pmx_etcd_0.alias,
    "ip"    = module.pmx_etcd_0.ip,
  }
}

module "pmx_etcd_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.etcd_servers[1]
  alias                = "${local.bt_product}-${local.tier}${local.bt_env}-etcd02"
  bt_infra_network     = local.db_env
  bt_infra_cluster     = local.cluster
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
  }
}

output "pmx_etcd_1" {
  value = {
    "fqdn"  = module.pmx_etcd_1.fqdn,
    "alias" = module.pmx_etcd_1.alias,
    "ip"    = module.pmx_etcd_1.ip,
  }
}

module "pmx_etcd_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.etcd_servers[2]
  alias                = "${local.bt_product}-${local.tier}${local.bt_env}-etcd03"
  bt_infra_network     = local.db_env
  bt_infra_cluster     = local.cluster
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
  }
}

output "pmx_etcd_2" {
  value = {
    "fqdn"  = module.pmx_etcd_2.fqdn,
    "alias" = module.pmx_etcd_2.alias,
    "ip"    = module.pmx_etcd_2.ip,
  }
}