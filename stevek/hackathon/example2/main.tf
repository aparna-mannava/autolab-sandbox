#comment
terraform {
  backend "http" {}
}

locals {
  cluster = "ny2-aza-ntnx-13"
    network = "ny2-autolab-app-ahv"
  os      = "rhel8"
  cpus    = "2"
  memory  = "2048"
  facts = {
    "bt_product" = "fml"
  }
  environment = "master"
  hostgroup   = "BT Base Server"
  datacenter  = "ny2"
  lob         = "fml"
}

module "example_module1" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlexpl124"
  alias               = "fml-ny2-skexample02"
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
}


output "example_module1" {
  value = {
    "fqdn"  = module.example_module1.fqdn,
    "alias" = module.example_module1.alias,
    "ip"    = module.example_module1.ip,
  }
}
