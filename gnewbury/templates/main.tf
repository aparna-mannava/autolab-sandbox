terraform {
  backend "s3" {}
}

locals {
  lob         = "CLOUD"
  hostname    = "us01vwcrnytest1"
  alias       = "inf-ny2-canarytest001"
  cpus        = "2"
  memory      = "2048"
  os          = "win2016"
  hostgroup   = "BT Base Windows Server"
  environment = "master"
  cluster     = "ny2-aze-ntnx-12"
  network     = "ny2-autolab-app-ahv"
  datacenter  = "ny2"
  facts = {
    bt_product = "inf"
    bt_tier    = "lab"
    bt_role    = "base"
  }
}

module "canary-test" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  canary              = true
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

output "canary-test" {
  value = {
    fqdn  = module.canary-test.fqdn
    alias = module.canary-test.alias
    ip    = module.canary-test.ip
  }
}
