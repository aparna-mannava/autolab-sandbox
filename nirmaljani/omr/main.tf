#
# Build the OMR PR DB server
#
terraform {
  backend "http" {}
}

locals {
  product     = "cloud"
  lob         = "CLOUD"
  environment = "feature_CLOUD_72532"
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
  hostname             = "us01vlomr098"
  alias                = "${local.product}-omr${local.facts.bt_env}-db01"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = "4"
  memory               = "8192"
  os_version           = "rhel7"
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT OMR Orac19c Server"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100",
    4 = "100",
    5 = "100",
    6 = "100",
    7 = "100"
  }
}

output "oradb_server_pr01" {
  value = {
    "fqdn"  = "${module.oradb_server_pr01.fqdn}",
    "alias" = "${module.oradb_server_pr01.alias}",
    "ip"    = "${module.oradb_server_pr01.ip}",
  }
}

module "oradb_server_pr02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlomr099"
  alias                = "${local.product}-omr${local.facts.bt_env}-db02"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = "4"
  memory               = "8192"
  os_version           = "rhel7"
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT OMR Orac19c Server"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100",
    4 = "100",
    5 = "100",
    6 = "100",
    7 = "100"
  }
}

output "oradb_server_pr02" {
  value = {
    "fqdn"  = "${module.oradb_server_pr02.fqdn}",
    "alias" = "${module.oradb_server_pr02.alias}",
    "ip"    = "${module.oradb_server_pr02.ip}",
  }
}


module "oradb_server_pr03" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlomr198"
  alias                = "${local.product}-omr${local.facts.bt_env}-db03"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = "4"
  memory               = "8192"
  os_version           = "rhel7"
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT OMR Orac19c Server"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  datacenter           = "${local.datacenter}"
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100",
    4 = "100",
    5 = "100",
    6 = "100",
    7 = "100"
  }
}

output "oradb_server_pr03" {
  value = {
    "fqdn"  = "${module.oradb_server_pr03.fqdn}",
    "alias" = "${module.oradb_server_pr03.alias}",
    "ip"    = "${module.oradb_server_pr03.ip}",
  }
}
