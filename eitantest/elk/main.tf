terraform {
  backend "s3" {}
}
#  Build test server
locals {
 # product     = "cfrmcloud"
 # environment = "feature_CFRMGC_219_puppet_test" 
  environment = "feature_CFRMCLOUD_916_cloud_admin_user_to_apachds"
  hostname    = "us01"
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }

  #|## Elk server module configuration ########|#
  e001 = { 
    hostname    = "${local.hostname}vlelk001"
    alias       = "${local.hostname}vlelastic001"
    silo        = "autolab"
    hostgroup   = "BT CFRM Eitan Test" 
    facts       = {
      "bt_product"  = "cfrmcloud"
      "bt_role" = "elastic"
      "bt_tier" = "autolab"
      "bt_lob" = "cfrm"
      "bt_artemis_version" = "2.11.0"
      "bt_es_version" = "7.8.0"
      "bt_apacheds_version" = "2.0.0_M24"
      "bt_jmx_prometheus_version" = "0.14.0"}
  }
}
module "e001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.e001.hostname}"
  alias               = "${local.e001.alias}"
  ## saas-p NY2 on IL02 subnet
  #bt_infra_cluster    = "il02-aza-ntnx-01"
  #bt_infra_network    = "il02_hosted_corp_app"
  ## auto.saas-n
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  bt_es_version       = "${local.e001.facts.bt_es_version}"
  bt_artemis_version  = "${local.e001.facts.bt_artemis_version}"
  bt_apacheds_version = "${local.e001.facts.bt_apacheds_version}"
  bt_jmx_prometheus_version = "${local.e001.facts.bt_jmx_prometheus_version}"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "2024"
  lob                 = "cfrm"
  external_facts      = "${local.e001.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.e001.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks    = {
    1 = "100", // disk1 100gb
  }
}

output "e001" {
  value = {
    "fqdn"  = "${module.e001.fqdn}",
    "alias" = "${module.e001.alias}",
    "ip"    = "${module.e001.ip}",
  }
}