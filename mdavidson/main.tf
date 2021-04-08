terraform {
  backend "s3" {}
}

locals {
  product        = "inf"
  environment    = "master"
  datacenter     = "ny2"
  hostgroup      = "BT Base Server"
  facts          = {
    "bt_product" = "inf"
    "bt_tier"    = "nonprod"
  }
}

module "inf_ny2_pam_testing" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlbh1003"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  lob                  = "CLOUD"
  memory               = "2048"
  external_facts       = "${local.facts}"
  foreman_environment  = "${local.environment}"
  foreman_hostgroup    = "${local.hostgroup}"
  datacenter           = "${local.datacenter}"
}

output "inf_ny2_pam_testing" {
  value = {
    "fqdn"  = "${module.inf_ny2_pam_testing.fqdn}",
    "alias" = "${module.inf_ny2_pam_testing.alias}",
    "ip"    = "${module.inf_ny2_pam_testing.ip}",
  }
}

