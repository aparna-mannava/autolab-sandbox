terraform {
  backend "s3" {}
}
#  Build test server
locals {
  environment = "feature_CLOUD_93508"
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }

  hostname    = "us01vlcfop001"
  alias       = "us01vlbasecfop001"
  silo        = "autolab"
  hostgroup   = "BT Base Server"
  facts       = {
    "bt_product"  = "postgres"
    "bt_role" = "postgres"
    "bt_tier" = "autolab"
    "bt_lob" = "cloud"
    "bt_pg_version" = "12"
    }
}

module "db__test_cfop01" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = local.hostname
  alias               = local.alias
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "4"
  memory              = "8096"
  lob                 = "cloud"
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter.name
  additional_disks    = {
    1 = "100", 
    2 = "50"
  }
}

output "db__test_cfop01" {
  value = {
    "fqdn"  = module.db__test_cfop01.fqdn,
    "alias" = module.db__test_cfop01.alias,
    "ip"    = module.db__test_cfop01.ip,
  }
}
