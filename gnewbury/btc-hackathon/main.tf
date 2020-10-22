terraform {
  backend "http" {}
}

module "example_btc" {
  source           = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname         = "us01vlexpl010"
  alias            = "btc-ny2-example01"
  bt_infra_cluster = "ny2-aza-ntnx-05"
  bt_infra_network = "ny2-autolab-app-ahv"
  os_version       = "rhel8"
  cpus             = "2"
  memory           = "2048"
  external_facts = {
    "bt_product" = "btc"
    "bt_tier"    = "test"
    "bt_role"    = "toolkit"
  }
  foreman_environment = "master"
  foreman_hostgroup   = "BT Base Server"
  datacenter          = "ny2"
  lob                 = "gbs"
}

output "example_btc_output" {
  value = {
    "fqdn"  = module.example_btc.fqdn
    "alias" = module.example_btc.alias
    "ip"    = module.example_btc.ip
  }
}
