terraform {
  backend "s3" {}
}

# Comment for backend migration

locals {
  product     = "fmcloud"
  #environment = "feature_FMDO_2314"
  environment = "master"
  hostgroup   = "BT FM Cloud ES Server"
  datacenter  = "ny2"
  image       = "rhel7"
  infra_cluster = "ny2-azd-ntnx-10"
  infra_network = "ny2-autolab-app"
  lob           = "FMCLOUD"
  master_memory = "8192"
  master_cpu    = "2"
  master_disks  = {
    1 = "102"
  }
  data_memory   = "8192"
  data_cpu      = "2"
  data_disks    = {
    1 = "255"
  }
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "es"
  }
}

module "es_master_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfm${local.facts.bt_role}001"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}-m1"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "es"
    "bt_env"            = "01"
    "es_type"           = "master"
  }
  cpus                 = local.master_cpu
  memory               = local.master_memory
  additional_disks     = local.master_disks
  lob                  = local.lob
}

output "es_master_1" {
  value = {
    "fqdn"  = module.es_master_1.fqdn,
    "alias" = module.es_master_1.alias,
    "ip"    = module.es_master_1.ip,
  }
}

module "es_master_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfm${local.facts.bt_role}002"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}-m2"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "es"
    "bt_env"            = "02"
    "es_type"           = "master"
  }
  cpus                 = local.master_cpu
  memory               = local.master_memory
  additional_disks     = local.master_disks
  lob                  = local.lob
}

output "es_master_2" {
  value = {
    "fqdn"  = module.es_master_2.fqdn,
    "alias" = module.es_master_2.alias,
    "ip"    = module.es_master_2.ip,
  }
}

module "es_master_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfm${local.facts.bt_role}003"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}-m3"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "es"
    "bt_env"            = "03"
    "es_type"           = "master"
  }
  cpus                 = local.master_cpu
  memory               = local.master_memory
  additional_disks     = local.master_disks
  lob                  = local.lob
}


output "es_master_3" {
  value = {
    "fqdn"  = module.es_master_3.fqdn,
    "alias" = module.es_master_3.alias,
    "ip"    = module.es_master_3.ip,
  }
}


module "es_data_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfm${local.facts.bt_role}004"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}-d1"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "es"
    "bt_env"            = "04"
    "es_type"           = "data"
  }
  cpus                 = local.data_cpu
  memory               = local.data_memory
  additional_disks     = local.data_disks
  lob                  = local.lob
}

output "es_data_1" {
  value = {
    "fqdn"  = module.es_data_1.fqdn,
    "alias" = module.es_data_1.alias,
    "ip"    = module.es_data_1.ip,
  }
}

module "es_data_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfm${local.facts.bt_role}005"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}-d2"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "es"
    "bt_env"            = "05"
    "es_type"           = "data"
  }
  cpus                 = local.data_cpu
  memory               = local.data_memory
  additional_disks     = local.data_disks
  lob                  = local.lob
}

output "es_data_2" {
  value = {
    "fqdn"  = module.es_data_2.fqdn,
    "alias" = module.es_data_2.alias,
    "ip"    = module.es_data_2.ip,
  }
}

module "es_data_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfm${local.facts.bt_role}006"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}-d3"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "es"
    "bt_env"            = "06"
    "es_type"           = "data"
  }
  cpus                 = local.data_cpu
  memory               = local.data_memory
  additional_disks     = local.data_disks
  lob                  = local.lob
}

output "es_data_3" {
  value = {
    "fqdn"  = module.es_data_3.fqdn,
    "alias" = module.es_data_3.alias,
    "ip"    = module.es_data_3.ip,
  }
}
