terraform {
  backend "s3" {}
}

module "patch_test" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlpatch001"
  alias               = "inf-ny2-patch01"
  bt_infra_cluster    = "ny2-azd-ntnx-10"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel8"
  cpus                = "2"
  memory              = "2048"
  foreman_environment = "feature_CLOUD_69442_patch_dates_override"
  foreman_hostgroup   = "BT Base Server"
  datacenter          = "ny2"
  lob                 = "CLOUD"
  external_facts = {
    "bt_product" = "inf"
  }
}

output "patch_test" {
  value = {
    "fqdn"  = module.patch_test.fqdn,
    "alias" = module.patch_test.alias,
    "ip"    = module.patch_test.ip,
  }
}
