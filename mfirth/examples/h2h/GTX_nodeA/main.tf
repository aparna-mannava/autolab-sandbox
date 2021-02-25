terraform {
  backend "http" {}
}

locals {
  cluster = "ny2-azb-ntnx-08"
  network = "ny2-autolab-app-ahv"
  #RHEL8
  os      = "rhel8"
  #set to 2 for autolab (set to 8 for SAAS-N)
  cpus    = "2"
  #set to 4096 for autolab (set to 32768 for SAAS-N)
  memory  = "4096"
  facts = {
    "bt_product" = "fml"
    "bt_tier" = "ts-saasn"
    "bt_role" = "gtxa"
  }
  environment = "master"
  hostgroup   = "BT FML GTX Servers"
  datacenter  = "ny2"
  lob         = "fml"
}

module "example_module1" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlh2hgtxa"
  alias               = "fml-ny2-h2hgtxa"
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  os_version          = local.os
  cpus                = local.cpus
  memory              = local.memory
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter
  lob                 = local.lob
  additional_disks     = {
  1 = "250"
}
}


output "example_module1" {
  value = {
    "fqdn"  = module.example_module1.fqdn,
    "alias" = module.example_module1.alias,
    "ip"    = module.example_module1.ip,
  }
}
#change to make file different
