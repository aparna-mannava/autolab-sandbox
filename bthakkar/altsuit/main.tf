terraform {
  backend "s3" {}
}
locals {
  product     = "cloud"
  environment = "feature_CLOUD_100728_db"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "sbx"
    "bt_env"  = "3"
    "bt_product" = "cloud"
    "bt_role" = "oradb"
  }
}
module "atlassian_dbserver_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlatldb111"
  alias                = "${local.product}-atl-${local.facts.bt_tier}${local.facts.bt_env}-db111"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Atlassian DB"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}
output "atlassian_dbserver_1" {
  value = {
    "fqdn"  = "${module.atlassian_dbserver_1.fqdn}",
    "alias" = "${module.atlassian_dbserver_1.alias}",
    "ip"    = "${module.atlassian_dbserver_1.ip}",
  }
}
