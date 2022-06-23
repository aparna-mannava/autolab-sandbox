terraform {
  backend "s3" {}
}

module "gn_test_01" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlgntst010"
  alias               = "ny2-gn-test010"
  bt_infra_cluster    = "ny2-aze-ntnx-12"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel8"
  cpus                = "2"
  memory              = "8192"
  foreman_environment = "master"
  lob                 = "CLOUD"
  foreman_hostgroup   = "BT Base Server"
  datacenter          = "ny2"
  external_facts = {
    bt_product = "inf"
    bt_role    = "test"
  }
}


output "gn_test_01" {
  value = {
    "fqdn"  = module.gn_test_01.fqdn,
    "alias" = module.gn_test_01.alias,
    "ip"    = module.gn_test_01.ip
  }
}
