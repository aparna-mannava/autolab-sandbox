terraform {
  backend "http" {}
}

locals {
  facts       = {
    "bt_tier"    = "dev"
    "bt_product" = "cagso"
    "bt_role" = "oracle"
    "bt_env"    = "1"
  }
}

module "cagso-oradb" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcagsora01"
  alias                = "cagso_oracle_12_auto_01"
  bt_infra_cluster     = "ny2-azd-ntnx-10"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "feature_CLOUD_65915"
  foreman_hostgroup    = "BT CFRM SP Oracle Server"
  datacenter           = "ny2"
  lob                  = "dev"
  cpus                 = "2"
  memory               = "8192"
  additional_disks     = {
  1 = "200",
  2 = "200",
  3 = "50",
  4 = "50",
  5 = "50"
}

output "cagso-oradb" {
  value = {
    "fqdn"  = "${module.cagso-oradb.fqdn}",
    "alias" = "${module.cagso-oradb.alias}",
    "ip"    = "${module.cagso-oradb.ip}",
  }

}
