terraform {
  backend "http" {}
}

locals {
  product       = "fmcloud"
  environment   = "feature_FMDO_1740"
  hostgroup     = "BT FM Cloud ES Server"
  datacenter    = "ny2"
  image         = "rhel7"
  infra_cluster = "ny2-aza-vmw-autolab"
  infra_network = "ny2-autolab-app"
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "es"
  }
}

module "test_master_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmes001"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}-m1"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = "${merge(
    local.facts,
    map(
      "bt_env", "01",
      "es_type", "master"
    )
  )}"
  cpus                 = "2"
  memory               = "16384"
  additional_disks     = {
    1 = "100"
  }
  lob                  = local.facts.bt_product
}

output "test_master_1" {
  value = {
    "fqdn"  = "${module.test_master_1.fqdn}",
    "alias" = "${module.test_master_1.alias}",
    "ip"    = "${module.test_master_1.ip}",
  }
}

module "es_data_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmes002"
  alias                = "fm-${local.facts.bt_loc}-${local.facts.bt_tier}-${local.facts.bt_role}-d1"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = "${merge(
    local.facts,
    map(
    "bt_env", "04",
    "es_type", "data"
    )
  )}"
  cpus                 = "2"
  memory               = "16384"
  additional_disks     = {
    1 = "100"
  }
  lob                  = local.facts.bt_product
}

output "es_data_1" {
  value = {
    "fqdn"  = "${module.es_data_1.fqdn}",
    "alias" = "${module.es_data_1.alias}",
    "ip"    = "${module.es_data_1.ip}",
  }
}
