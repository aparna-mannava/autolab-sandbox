terraform {
  backend "http" {}
}

locals {
  etcd_servers    = ["us01vlcfrmrd601","us01vlcfrmrd602","us01vlcfrmrd603"]
  hapg_servers    = ["us01vlcfrmrd604","us01vlcfrmrd605","us01vlcfrmrd606"]
  haproxy_server  = ["us01vlcfrmrd600"]
  backrest_server = ["us01vlcfrmrd666"]
 
  etcd_aliases    = ["cfrmrd-etcd1","cfrmrd-etcd2","cfrmrd-etcd3"]
  hapg_aliases    = ["cfrmrd-hapg1","cfrmrd-hapg2","cfrmrd-hapg3"]
  haproxy_alias   = ["cfrmrd-proxy"]
  backrest_alias  = ["cfrmrd-backrest"]
      
  etcd_hosts_p    = ["'us01vlcfrmrd601.auto.saas-n.com','us01vlcfrmrd602.auto.saas-n.com','us01vlcfrmrd603.auto.saas-n.com'"]
  domain          = "auto.saas-n.com"
  tier            = "autolab"
  bt_env          = "1"
  bt_product      = "cfrmrd"
  lob             = "CFRM"
  hostgroup       = "BT HA PG Server"
  environment     = "CFRMX-3466-HA-Postgres"
  cluster         = "ny2-aza-ntnx-07"
  network         = "ny2-autolab-app-ahv"
  facts           = {
    "bt_env"                  = "${local.bt_env}"
    "bt_tier"                 = "${local.tier}"
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}", "${local.hapg_servers[2]}.${local.domain}"]
    "bt_hapg_node1"           = "${local.hapg_servers[0]}.${local.domain}"
    "bt_hapg_node2"           = "${local.hapg_servers[1]}.${local.domain}"
    "bt_hapg_node3"           = "${local.hapg_servers[2]}.${local.domain}"
    "bt_backup_node"          = "${local.backrest_server[0]}.${local.domain}"
    "bt_cluster_name"         = "dev8cluster"
  }
}

module "etcd_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[0]}"
  alias                = "${local.etcd_aliases[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = "BT ETCD for PostgreSQL Server"
  foreman_environment  = local.environment
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "200",
  }
}

module "etcd_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[1]}"
  alias                = "${local.etcd_aliases[1]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT ETCD for PostgreSQL Server"
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "200",
  }
}

module "etcd_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[2]}"
  alias                = "${local.etcd_aliases[2]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT ETCD for PostgreSQL Server"
  lob                  = local.lob
  foreman_environment  = local.environment
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "200",
  }
}

module "hapg_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[0]}"
  alias                = "${local.hapg_aliases[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = "BT HA PG Server"
  foreman_environment  = local.environment
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
  1 = "100",
  2 = "150",
  3 = "150",
  }
}

module "hapg_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[1]}"
  alias                = "${local.hapg_aliases[1]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT HA PG Server"
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
  1 = "100",
  2 = "150",
  3 = "150",
  }
}

module "hapg_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hapg_servers[2]}"
  alias                = "${local.hapg_aliases[2]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT HA PG Server"
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
    2 = "150",
    3 = "150",
  }
}

module "haproxy_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.haproxy_server[0]}"
  alias                = "${local.haproxy_alias[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT Patroni HA Proxy"
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
    2 = "10",
  }
}

module "backrest_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.backrest_server[0]}"
  alias                = "${local.backrest_alias[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = "BT PG Backrest Server"
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
    2 = "150",
    3 = "150",
  }
}

output "backrest_1" {
  value = {
    "fqdn"  = "${module.backrest_1.fqdn}",
    "alias" = "${module.backrest_1.alias}",
    "ip"    = "${module.backrest_1.ip}",
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

output "hapg_0" {
  value = {
    "fqdn"  = "${module.hapg_0.fqdn}",
    "alias" = "${module.hapg_0.alias}",
    "ip"    = "${module.hapg_0.ip}",
  }
}

output "hapg_1" {
  value = {
    "fqdn"  = "${module.hapg_1.fqdn}",
    "alias" = "${module.hapg_1.alias}",
    "ip"    = "${module.hapg_1.ip}",
  }
}

output "hapg_2" {
  value = {
    "fqdn"  = "${module.hapg_2.fqdn}",
    "alias" = "${module.hapg_2.alias}",
    "ip"    = "${module.hapg_2.ip}",
  }
}

output "haproxy_1" {
  value = {
    "fqdn"  = "${module.haproxy_1.fqdn}",
    "alias" = "${module.haproxy_1.alias}",
    "ip"    = "${module.haproxy_1.ip}",
  }
}