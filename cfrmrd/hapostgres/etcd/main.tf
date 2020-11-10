terraform {
  backend "http" {}
}

locals {
  etcd_servers    = ["us01vlcfrmrd601","us01vlcfrmrd602","us01vlcfrmrd603"]
  etcd_hosts_p    = ["'us01vlcfrmrd601.auto.saas-n.com','us01vlcfrmrd602.auto.saas-n.com','us01vlcfrmrd603.auto.saas-n.com'"]
  etcd_aliases    = ["cfrmrd-etcd1","cfrmrd-etcd2","cfrmrd-etcd3"]
  domain          = "auto.saas-n.com"
  bt_product      = "cfrmrd"
  lob             = "CFRM"
  hostgroup       = "CFRMRD ETCD for PostgreSQL Server"
  environment     = "feature_CFRMX_3466_HA_Postgres"
  cluster         = "ny2-aza-ntnx-13"
  network         = "ny2-autolab-app-ahv"
  facts           = {
    "bt_product"              = "${local.bt_product}"
    "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
    "bt_cluster_name"         = "cfrmrd_cluster"
  }
}

module "ny2_autolab_etcd_0" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[0]}"
  alias                = "${local.etcd_aliases[0]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

module "ny2_autolab_etcd_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[1]}"
  alias                = "${local.etcd_aliases[1]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  foreman_environment  = local.environment
  lob                  = local.lob
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

module "ny2_autolab_etcd_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.etcd_servers[2]}"
  alias                = "${local.etcd_aliases[2]}"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  foreman_hostgroup    = local.hostgroup
  lob                  = local.lob
  foreman_environment  = local.environment
  os_version           = "rhel7"
  cpus                 = "1"
  memory               = "4096"
  external_facts       = local.facts
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

output "ny2_autolab_etcd_0" {
  value = {
    "fqdn"  = "${module.ny2_autolab_etcd_0.fqdn}",
    "alias" = "${module.ny2_autolab_etcd_0.alias}",
    "ip"    = "${module.ny2_autolab_etcd_0.ip}",
  }
}

output "ny2_autolab_etcd_1" {
  value = {
    "fqdn"  = "${module.ny2_autolab_etcd_1.fqdn}",
    "alias" = "${module.ny2_autolab_etcd_1.alias}",
    "ip"    = "${module.ny2_autolab_etcd_1.ip}",
  }
}

output "ny2_autolab_etcd_2" {
  value = {
    "fqdn"  = "${module.ny2_autolab_etcd_2.fqdn}",
    "alias" = "${module.ny2_autolab_etcd_2.alias}",
    "ip"    = "${module.ny2_autolab_etcd_2.ip}",
  }
}  