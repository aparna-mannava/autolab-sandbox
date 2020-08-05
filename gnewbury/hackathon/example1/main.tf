terraform {
  backend "http" {}
}

module "example_module" {
  source           = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname         = "us01vlexpl001"
  alias            = "fml-ny2-example01"
  bt_infra_cluster = "ny2-azd-ntnx-10"
  bt_infra_network = "ny2-autolab-app-ahv"
  os_version       = "rhel8"
  cpus             = "2"
  memory           = "2048"
  external_facts = {
    "bt_product" = "fml"
  }
  foreman_environment = "master"
  foreman_hostgroup   = "BT Base Server"
  datacenter          = "ny2"
  lob                 = "fml"
}

output "example_module" {
  value = {
    "fqdn"  = module.example_module.fqdn,
    "alias" = module.example_module.alias,
    "ip"    = module.example_module.ip,
  }
}