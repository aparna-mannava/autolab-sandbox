terraform {
  backend "s3" {}
}

locals {
  es_hostname             = ["us01vliqes01","us01vliqes02","us01vliqes03","us01vliqes04","us01vliqes05","us01vliqes06"]
  initial_master_nodes    = ["us01vliqes01-btiq-es","us01vliqes02-btiq-es","us01vliqes03-btiq-es"]
  domain                  = "saas-n.com"
  tier                    = "dev"
  datacenter              = "ny2"
  image                   = "rhel7"
  bt_product              = "btiq"
  lob                     = "btiq"
  environment             = "feature_BTIQ_77_jenkins"
  hostgroup               = "BTIQ ES Cluster"
  infra_cluster           = "us-01-vn-nutanix09"
  infra_network           = "ny2-autolab-db-ahv"
  master_memory           = "2048"
  master_cpu              = "2"
  master_disks            = {
    1 = "102"
  }
  data_memory             = "2048"
  data_cpu                = "2"
  data_disks              = {
    1 = "255"
  }

  facts                       = {
    "bt_tier"                 = "${local.tier}"
    "bt_loc"                  = "${local.datacenter}"
    "bt_product"              = "${local.bt_product}"
    "bt_seeds_hosts"          = ["${local.es_hostname[0]}.${local.domain}", "${local.es_hostname[1]}.${local.domain}", "${local.es_hostname[2]}.${local.domain}"]
    "bt_initial_master_nodes" = ["${local.initial_master_nodes[0]}", "${local.initial_master_nodes[1]}", "${local.initial_master_nodes[2]}"]
    "bt_role"                 = "elasticsearch"
    "bt_cluster_name"         = "btiqescluster"
    "firewall_group"          = "BTIQ_NY2_INTEGRATION_AUDIT_LOG_DB"
  }
}

module "es_master_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.es_hostname[0]}"
  alias                = "btiq-${local.facts.bt_loc}-${local.facts.bt_tier}-es-m1"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  firewall_group       = "${local.facts.firewall_group}"
  datacenter           = local.datacenter
  external_facts       = "${merge(
    local.facts,
    map(
      "bt_env", "01",
      "es_type", "master"
    )
  )}"
  cpus                 = local.master_cpu
  memory               = local.master_memory
  additional_disks     = local.master_disks
  lob                  = local.facts.bt_product

}

output "es_master_1" {
  value = {
    "fqdn"  = "${module.es_master_1.fqdn}",
    "alias" = "${module.es_master_1.alias}",
    "ip"    = "${module.es_master_1.ip}",
  }
}

module "es_master_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.es_hostname[1]}"
  alias                = "iq-${local.facts.bt_loc}-${local.facts.bt_tier}-es-m2"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  firewall_group       = "${local.facts.firewall_group}"
  datacenter           = local.datacenter
  external_facts       = "${merge(
    local.facts,
    map(
    "bt_env", "02",
    "es_type", "master"
    )
  )}"
  cpus                 = local.master_cpu
  memory               = local.master_memory
  additional_disks     = local.master_disks
  lob                  = local.facts.bt_product

}

output "es_master_2" {
  value = {
    "fqdn"  = "${module.es_master_2.fqdn}",
    "alias" = "${module.es_master_2.alias}",
    "ip"    = "${module.es_master_2.ip}",
  }
}

module "es_master_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.es_hostname[2]}"
  alias                = "iq-${local.facts.bt_loc}-${local.facts.bt_tier}-es-m3"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  firewall_group       = "${local.facts.firewall_group}"
  datacenter           = local.datacenter
  external_facts       = "${merge(
    local.facts,
    map(
    "bt_env", "03",
    "es_type", "master"
    )
  )}"
  cpus                 = local.master_cpu
  memory               = local.master_memory
  additional_disks     = local.master_disks
  lob                  = local.facts.bt_product

}


output "es_master_3" {
  value = {
    "fqdn"  = "${module.es_master_3.fqdn}",
    "alias" = "${module.es_master_3.alias}",
    "ip"    = "${module.es_master_3.ip}",
  }
}


module "es_data_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.es_hostname[3]}"
  alias                = "iq-${local.facts.bt_loc}-${local.facts.bt_tier}-es-d1"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  firewall_group       = "${local.facts.firewall_group}"
  datacenter           = local.datacenter
  external_facts       = "${merge(
    local.facts,
    map(
    "bt_env", "04",
    "es_type", "data"
    )
  )}"
  cpus                 = local.data_cpu
  memory               = local.data_memory
  additional_disks     = local.data_disks
  lob                  = local.facts.bt_product

}

output "es_data_1" {
  value = {
    "fqdn"  = "${module.es_data_1.fqdn}",
    "alias" = "${module.es_data_1.alias}",
    "ip"    = "${module.es_data_1.ip}",
  }
}

module "es_data_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.es_hostname[4]}"
  alias                = "iq-${local.facts.bt_loc}-${local.facts.bt_tier}-es-d2"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  firewall_group       = "${local.facts.firewall_group}"
  datacenter           = local.datacenter
  external_facts       = "${merge(
    local.facts,
    map(
    "bt_env", "05",
    "es_type", "data"
    )
  )}"
  cpus                 = local.data_cpu
  memory               = local.data_memory
  additional_disks     = local.data_disks
  lob                  = local.facts.bt_product

}

output "es_data_2" {
  value = {
    "fqdn"  = "${module.es_data_2.fqdn}",
    "alias" = "${module.es_data_2.alias}",
    "ip"    = "${module.es_data_2.ip}",
  }
}

module "es_data_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.es_hostname[5]}"
  alias                = "iq-${local.facts.bt_loc}-${local.facts.bt_tier}-es-d3"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  firewall_group       = "${local.facts.firewall_group}"
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = "${merge(
    local.facts,
    map(
    "bt_env", "06",
    "es_type", "data"
    )
  )}"
  cpus                 = local.data_cpu
  memory               = local.data_memory
  additional_disks     = local.data_disks
  lob                  = local.facts.bt_product

}

output "es_data_3" {
  value = {
    "fqdn"  = "${module.es_data_3.fqdn}",
    "alias" = "${module.es_data_3.alias}",
    "ip"    = "${module.es_data_3.ip}",
  }
}
