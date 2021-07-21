terraform {
  backend "s3" {}
}
#  Build test server
locals {
  environment = "feature_CFRMCLOUD_1048_cfrm_standalone"
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }

  hostname    = "us01vlcfrm053"
  alias       = "us01vlbasecfrm053"
  silo        = "autolab"
  hostgroup   = "BT CFRM CLOUD Application Standalone"
  facts       = {
    "bt_product"  = "cfrmcloud"
    "bt_role" = "cfrm"
    "bt_tier" = "autolab"
    "bt_lob" = "cfrm"
    #"bt_db_url" = "us01vlcfdblab01.auto.saas-n.com:1560/CFRMAU01"
    # "bt_artemis_version" = "2.11.0"
    # "bt_es_version" = "7.8.0"
    # "bt_apacheds_version" = "2.0.0_M24"
    # "bt_jmx_prometheus_version" = "0.14.0"
    "bt_ic_version" = "640_SP1"
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
  cpus                = "8"
  memory              = "32000"
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