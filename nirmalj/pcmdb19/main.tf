terraform {
  backend "s3" {}
}

locals {
  product     = "pcm"
  environment = "feature_CLOUD_102699"
  datacenter  = "ny2"
  facts                    = {
    "bt_product"           = "pcm"
    "bt_tier"              = "qa"
    "bt_env"               = "19"
    "bt_customer"          = "fi9001"
    "oracle_patch_version" = "19"
    "bt_role"              = "oradb"
  }
}

module "oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltdpcm19"
  alias                = "${local.product}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-db19"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = "4"
  memory               = "8192"
  os_version           = "rhel7"
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT PCM ORADB"
  external_facts       = local.facts
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100"
  }
}

module "oradb_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlgapcm19"
  alias                = "${local.product}-ga${local.facts.bt_env}-${local.facts.bt_customer}-db19"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = "4"
  memory               = "8192"
  os_version           = "rhel7"
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT PCM GADATA ORADB"
  external_facts       = local.facts
  foreman_environment  = local.environment
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100"
  }
}

output "oradb_server_1" {
  value = {
    "fqdn"  = module.oradb_server_1.fqdn,
    "alias" = module.oradb_server_1.alias,
    "ip"    = module.oradb_server_1.ip,
  }
}

output "oradb_server_2" {
  value = {
    "fqdn"  = module.oradb_server_2.fqdn,
    "alias" = module.oradb_server_2.alias,
    "ip"    = module.oradb_server_2.ip,
  }
}
