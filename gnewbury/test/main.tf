terraform {
  backend "s3" {}
}

module "test" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlgntst001"
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel8"
  cpus                = "2"
  memory              = "4096"
  foreman_environment = "master"
  lob                 = "CLOUD"
  foreman_hostgroup   = "BT Base Server"
  datacenter          = "ny2"
  external_facts = {
    bt_product = "cloud"
    bt_role    = "test"
  }
}

output "test" {
  value = {
    "fqdn"  = module.test.fqdn,
    "alias" = module.test.alias,
    "ip"    = module.test.ip
  }
}
