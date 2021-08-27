terraform {
  backend "s3" {}
}

locals {
  etcd_servers    = ["gb03etcdfm01","gb03vletcdfm02","gb03vletcdfm03"]
  hapg_servers    = ["gb03vlpgfm01","gb03vlpgfm02","gb03vlpgfm03"]
  haproxy_server  = ["gb03vlhapxfm01"]
  backrest_server = ["gb03vlbkpfm01"]
  etcd_hosts_p    = ["'gb03vletcdfm01.auto.saas-n.com','gb03vletcdfm02.auto.saas-n.com','gb03vletcdfm03.auto.saas-n.com'"]
  os              = "rhel7"
  domain          = "auto.saas-n.com"
  datacenter      = "ny2"
  tier            = "prd"
  bt_env          = "1"
  bt_product      = "fmlsaas"
  lob             = "FML"
  environment     = "production"
  cluster         = "ny5-azc-ntnx-16"
  network         = "ny2-autolab-app-ahv"
  etcd_hostgroup  = "BT ETCD for PostgreSQL Server"
  pg_datacenter   = "ny2"
  pg_tier         = "prd"
  pg_hostgroup    = "BT Postgresql fmlsaas DB Server"
  hapxy_hostgroup = "BT Patroni HA Proxy"
  facts           = {
    "bt_pg_version"           = "12"
    "bt_env"                  = "${local.bt_env}"
    "bt_tier"                 = "${local.tier}"
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}", "${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
  }
}

module "etcd_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[0]}"
  alias                = "fm-${local.pg_datacenter}-${local.pg_tier}-etcd1"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.etcd_hostgroup
  foreman_environment  = local.environment
  os_version           = local.os
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

module "etcd_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[1]}"
  alias                = "fm-${local.pg_datacenter}-${local.pg_tier}-etcd2"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.etcd_hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = local.os
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

module "etcd_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[2]}"
  alias                = "fm-${local.pg_datacenter}-${local.pg_tier}-etcd3"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.etcd_hostgroup
  lob                  = local.lob
  foreman_environment  = local.environment
  os_version           = local.os
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

output "etcd_0" {
  value = {
    "fqdn"  = "${module.etcd_0.fqdn}",
    "alias" = "${module.etcd_0.alias}",
    "ip"    = "${module.etcd_0.ip}",
  }
}

output "etcd_1" {
  value = {
    "fqdn"  = "${module.etcd_1.fqdn}",
    "alias" = "${module.etcd_1.alias}",
    "ip"    = "${module.etcd_1.ip}",
  }
}

output "etcd_2" {
  value = {
    "fqdn"  = "${module.etcd_2.fqdn}",
    "alias" = "${module.etcd_2.alias}",
    "ip"    = "${module.etcd_2.ip}",
  }
}
