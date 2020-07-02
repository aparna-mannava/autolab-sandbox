terraform {
  backend "http" {}
}

locals {
  product     = "cloud"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "qa"
    "bt_env"  = "2"
    "bt_customer" = "ciscat"
    "bt_role" = "oradb"
  }
}

module "ciscat_dbserver_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlciscat22"
  alias                = ""
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_environment = "ny2-autolab-db-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT CLOUD ORADB ciscat"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200",
    4 = "200"
  }
}

output "ciscat_dbserver_1" {
  value = {
    "fqdn"  = "${module.ciscat_dbserver_1.fqdn}",
    "alias" = "${module.ciscat_dbserver_1.alias}",
    "ip"    = "${module.ciscat_dbserver_1.ip}",
  }
}
