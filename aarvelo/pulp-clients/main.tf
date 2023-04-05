terraform {
  backend "s3" {}
}

locals {
  product     = "inf"
  environment = "feature_CLOUD_120225_Pulp"
  datacenter  = "ny2"
  lob         = "CLOUD"
  tier        = "autolab"
  facts       = {
    "bt_product" = "inf",
  }

  pulp_client01 = {
    hostname  = "us01vlpulpc100"
    alias     = ""
    hostgroup = "BT Base Server"
    cpu       = "2"
    memory    = "8192"
    os        = "rhel7"
    cluster   = "ny5-azh-ntnx-26"
    network   = "ny2-autolab-app-ahv"
    facts     = merge(local.facts, { "bt_tier" = "autolab"})
  }

  pulp_client02 = {
    hostname  = "us01vlpulpc200"
    alias     = ""
    hostgroup = "BT Base Server"
    cpu       = "2"
    memory    = "8192"
    os        = "rhel8"
    cluster   = "ny5-azh-ntnx-26"
    network   = "ny2-autolab-app-ahv"
    facts     = merge(local.facts, { "bt_tier" = "autolab"})
  }

}

module "pulp_client01" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.pulp_client01.hostname
  alias                = local.pulp_client01.alias
  bt_infra_cluster     = local.pulp_client01.cluster
  bt_infra_network     = local.pulp_client01.network
  os_version           = local.pulp_client01.os
  cpus                 = local.pulp_client01.cpu
  memory               = local.pulp_client01.memory
  external_facts       = local.pulp_client01.facts
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.pulp_client01.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

module "pulp_client02" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.pulp_client02.hostname
  alias                = local.pulp_client02.alias
  bt_infra_cluster     = local.pulp_client02.cluster
  bt_infra_network     = local.pulp_client02.network
  os_version           = local.pulp_client02.os
  cpus                 = local.pulp_client02.cpu
  memory               = local.pulp_client02.memory
  external_facts       = local.pulp_client02.facts
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.pulp_client02.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100",
  }
}

output "pulp_client01" {
  value = {
    "fqdn"  = module.pulp_client01.fqdn,
    "alias" = module.pulp_client01.alias,
    "ip"    = module.pulp_client01.ip,
  }
}

output "pulp_client02" {
  value = {
    "fqdn"  = module.pulp_client02.fqdn,
    "alias" = module.pulp_client02.alias,
    "ip"    = module.pulp_client02.ip,
  }
}

