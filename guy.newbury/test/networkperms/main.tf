terraform {
  backend "s3" {}
}

locals {
  hostname    = "us01vlnwpm001"
  alias       = "inf-us01-netperms001"
  os          = "rhel8"
  cpu         = 2
  ram         = 2048
  hostgroup   = "BT Base Server"
  environment = "master"
  cluster     = "ny2-aza-ntnx-13"
  network     = "ny2-autolab-app-ahv"
  facts = {
    "bt_product" = "inf"
  }
}

module "network-perm-test" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CLOUD-76109_network_permissions"
  hostname            = local.hostname
  alias               = local.alias
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  os_version          = local.os
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = "ny2"
  lob                 = "cloud"
  cpus                = local.cpu
  memory              = local.ram
  external_facts      = local.facts
}

output "network-perm-test" {
  value = {
    "fqdn"  = module.network-perm-test.fqdn
    "alias" = module.network-perm-test.alias
    "ip"    = module.network-perm-test.ip
  }
}
