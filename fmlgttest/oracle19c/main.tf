terraform {
  backend "http" {}
}

locals {
  product     = "cloud"
  environment = "feature_CLOUD_86050"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "pr"
    "bt_env"  = "2"
    "bt_role" = "oradb"
    "bt_customer" = "lly"
  }
}

module "oradb_dbserver_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmldb1"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  lob                  = "CLOUD"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT FMLGT Oracle Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "400",
    2 = "100",
    3 = "100"
  }
}

output "oradb_dbserver_1" {
  value = {
    "fqdn"  = "${module.oradb_dbserver_1.fqdn}",
    "ip"    = "${module.oradb_dbserver_1.ip}",
  }
}
