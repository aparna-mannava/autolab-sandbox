terraform {
  backend "http" {}
}

module "test_101" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlrgtest101"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CEA"
  external_facts       = {
    "bt_product" = "cloud"
  }
}

output "test_servers" {
  value = {
    "${module.test_101.fqdn}" = "${module.test_101.ip}"
  }
}
