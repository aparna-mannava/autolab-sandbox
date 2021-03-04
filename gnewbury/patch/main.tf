terraform {
  backend "s3" {}
}

locals {
  lob         = "CLOUD"
  hostname    = "us01vlpatcht001"
  alias       = "inf-ny2-patchtest001"
  cpus        = "2"
  memory      = "2048"
  os          = "rhel8"
  hostgroup   = "BT Base Server"
  environment = "feature_CLOUD_83256_find_patches"
  cluster     = "ny2-aza-ntnx-13"
  network     = "ny2-autolab-app-ahv"
  datacenter  = "ny2"
  facts = {
    bt_product = "inf"
    bt_tier    = "lab"
    bt_role    = "base"
  }
}

module "patch-test" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  lob                 = locals.lob
  hostname            = locals.hostname
  alias               = locals.alias
  cpus                = locals.cpus
  memory              = locals.memory
  os_version          = locals.os
  foreman_hostgroup   = locals.hostgroup
  foreman_environment = locals.environment
  bt_infra_cluster    = locals.cluster
  bt_infra_network    = locals.network
  datacenter          = locals.datacenter
  external_facts      = locals.facts
}

output "patch-test" {
  value = {
    fqdn  = module.patch-test.fqdn
    alias = module.patch-test.alias
    ip    = module.patch-test.ip
  }
}
