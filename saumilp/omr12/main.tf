#
# Build the OMR DB server
#
terraform {
  backend "http" {}
}
locals {
  product     = "cloud"
  lob         = "CLOUD"
  environment = "feature_omr_cloud_72532"
  datacenter  = "ny2"
  facts           = {
    "bt_product"  = "cloud"
    "bt_tier"     = "pr"
    "bt_role"     = "oradb"
    "bt_env"      = 1
  }
}

module "oradb_server_pr01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlomrdb7"
  alias                = "${local.product}-omr-db7"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = "4"
  memory               = "8192"
  os_version           = "rhel7"
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT OMR Oracle12 Server"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "50",
    4 = "50",
    5 = "50",
    6 = "50",
    7 = "50"
  }
}

output "oradb_server_pr01" {
  value = {
    "fqdn"  = "${module.oradb_server_pr01.fqdn}",
    "alias" = "${module.oradb_server_pr01.alias}",
    "ip"    = "${module.oradb_server_pr01.ip}",
  }
}
