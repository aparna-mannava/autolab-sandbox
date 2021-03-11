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
  environment = "feature_CLOUD_83257_pulp_sync"
  cluster     = "ny2-azb-ntnx-08"
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
  lob                 = local.lob
  hostname            = local.hostname
  alias               = local.alias
  cpus                = local.cpus
  memory              = local.memory
  os_version          = local.os
  foreman_hostgroup   = local.hostgroup
  foreman_environment = local.environment
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  datacenter          = local.datacenter
  external_facts      = local.facts
}

output "patch-test" {
  value = {
    fqdn  = module.patch-test.fqdn
    alias = module.patch-test.alias
    ip    = module.patch-test.ip
  }
}
