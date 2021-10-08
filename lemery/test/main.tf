terraform {
  backend "s3" {}
}

locals {
  image         = "rhel7"
  hostgroup     = "BT Base Server"
  environment   = "feature_CEA_4699_lae_test"
  datacenter    = "ny2"
  cluster       = "ny2-aza-ntnx-07"
  network       = "ny2-autolab-app-ahv"
  cpus          = "4"
  memory        = "8192"
  disks     = {
    1 = "500",
  }
  facts         = {
    "bt_product"      = "inf"
    "bt_role"         = "test"
    "bt_tier"         = "autolab"
    "bt_env"          = "1"
  }
}

module "base_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlapp2066"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  additional_disks     = local.disks
  external_facts       = local.facts
  lob                  = "CEA"
}

output "base_server_1" {
  value = {
    "fqdn"  = module.base_server_1.fqdn,
    "alias" = module.base_server_1.alias,
    "ip"    = module.base_server_1.ip,
  }
}

