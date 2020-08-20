#
# Build the JLL PR Oracle Database server
#
terraform {
  backend "http" {}
}

locals {
  product     = "wsjjll"
  lob         = "NACP"
  environment = "feature_CLOUD_69263"
  datacenter  = "ny2"
  facts           = {
    "bt_product"  = "wsjjll"
    "bt_tier"     = "pr"
    "bt_env"      = "1"
    "bt_role"     = "oradb"
    "bt_customer" = "fi9001"
  }
}

module "oradb_server_pr01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlwjldb01"
  alias                = "${local.product}-np${local.facts.bt_env}-${local.facts.bt_customer}-db01"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-db-ahv"
  cpus                 = "4"
  memory               = "8192"
  os_version           = "rhel7"
  lob                  = "NACP"
  foreman_hostgroup    = "BT WSJJLL ORADB"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "500",
    2 = "100",
    3 = "100",
    4 = "100",
    5 = "100"
  }
}

output "oradb_server_pr01" {
  value = {
    "fqdn"  = "${module.oradb_server_pr01.fqdn}",
    "alias" = "${module.oradb_server_pr01.alias}",
    "ip"    = "${module.oradb_server_pr01.ip}",
  }
}
