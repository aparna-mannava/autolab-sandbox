terraform {
  backend "s3" {}
}

locals {
  product     = "inf"
  environment = "feature_CLOUD_64222_Ivanti_Agent_Updates"
  datacenter  = "ny2"
  lob         = "CLOUD"
  tier        = "autolab"
  facts       = {
    "bt_product" = "inf",
  }

  ivanti_test01 = {
    hostname  = "us01vwivanti99"
    alias     = ""
    hostgroup = "BT Base Windows Server"
    cpu       = "2"
    memory    = "8192"
    os        = "win2022"
    cluster   = "ny5-azh-ntnx-26"
    network   = "ny2-autolab-app-ahv"
    facts     = merge(local.facts, { "bt_tier" = "autolab"})
  }

}

module "ivanti_test01" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.ivanti_test01.hostname
  alias                = local.ivanti_test01.alias
  bt_infra_cluster     = local.ivanti_test01.cluster
  bt_infra_network     = local.ivanti_test01.network
  os_version           = local.ivanti_test01.os
  cpus                 = local.ivanti_test01.cpu
  memory               = local.ivanti_test01.memory
  external_facts       = local.ivanti_test01.facts
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.ivanti_test01.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

output "ivanti_test01" {
  value = {
    "fqdn"  = module.ivanti_test01.fqdn,
    "alias" = module.ivanti_test01.alias,
    "ip"    = module.ivanti_test01.ip,
  }
}
