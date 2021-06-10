terraform {
  backend "s3" {}
}
#  Build test server
locals {
  environment = "feature_CFRMCLOUD_131_cfrm_install_standalone"
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }

  hostname    = "us01vlcfrm001"
  alias       = "us01vlbasecfrm001"
  silo        = "autolab"
  hostgroup   = "BT CFRM Eitan Test"
  facts       = {
    "bt_product"  = "cfrmcloud"
    "bt_role" = "cfrm"
    "bt_tier" = "autolab"
    "bt_lob" = "cfrm"
    # "bt_artemis_version" = "2.11.0"
    # "bt_es_version" = "7.8.0"
    # "bt_apacheds_version" = "2.0.0_M24"
    # "bt_jmx_prometheus_version" = "0.14.0"
    "bt_ic_version" = "6.4.0_SP1"
    }
}

module "cfrm001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = local.hostname
  alias               = local.alias
  ## saas-p NY2 on IL02 subnet
  #bt_infra_cluster    = "il02-aza-ntnx-01"
  #bt_infra_network    = "il02_hosted_corp_app"
  ## auto.saas-n
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "2024"
  lob                 = "cfrm"
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter.name
  additional_disks    = {
    1 = "100", // disk1 100gb
  }
}

output "cfrm001" {
  value = {
    "fqdn"  = module.cfrm001.fqdn,
    "alias" = module.cfrm001.alias,
    "ip"    = module.cfrm001.ip,
  }
}