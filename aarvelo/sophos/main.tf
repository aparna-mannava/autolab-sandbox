terraform {
  backend "s3" {}
}

locals {
  product        = "inf"
  environment    = "feature_CLOUD_97021_Sophos"
  datacenter     = "ny2"
  cpus           = "2"
  memory         = "8192"
  lob            = "CLOUD"
  facts          = {
    "bt_product" = "inf"
  }

  win001 = {
    hostname  = "us01vwwin001"
    hostgroup = "BT Base Windows Server"
    os        = "win2016"
    cluster   = "ny5-azc-ntnx-16"
    network   = "ny2-autolab-app-ahv"
    facts     = merge(local.facts, { "bt_tier" = "autolab"})
  }

  win002 = {
    hostname  = "us01vwwin002"
    hostgroup = "BT Base Windows Server"
    os        = "win2019"
    cluster   = "ny5-azc-ntnx-16"
    network   = "ny2-autolab-app-ahv"
    facts     = merge(local.facts, { "bt_tier" = "autolab"})
  }

}

module "win001" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.win001.hostname
  alias                = ""
  bt_infra_cluster     = local.win001.cluster
  bt_infra_network     = local.win001.network
  os_version           = local.win001.os
  cpus                 = local.cpus
  memory               = local.memory
  external_facts       = local.win001.facts
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.win001.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

module "win002" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.win002.hostname
  alias                = ""
  bt_infra_cluster     = local.win002.cluster
  bt_infra_network     = local.win002.network
  os_version           = local.win002.os
  cpus                 = local.cpus
  memory               = local.memory
  external_facts       = local.win002.facts
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.win002.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

output "win001" {
  value = {
    "fqdn"  = module.win001.fqdn,
    "alias" = module.win001.alias,
    "ip"    = module.win001.ip,
  }
}

output "win002" {
  value = {
    "fqdn"  = module.win002.fqdn,
    "alias" = module.win002.alias,
    "ip"    = module.win002.ip,
  }
}
