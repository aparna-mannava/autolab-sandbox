terraform {
  backend "http" {}
}

locals {
  product       = "inf"
  environment   = "feature_CLOUD_66662_packer_windows"
  datacenter    = "ny2"
  hostgroup     = "BT Packer Server"
  hostname_part = "us01vlpacker"
  facts = {
    "bt_product" = "cloud"
    "bt_role"    = "packer"
    "bt_tier"    = "test"
  }
  cluster = "ny2-aza-vmw-autolab"
  network = "ny2-autolab-app"
  lob     = "CLOUD"
  os      = "rhel7"
  memory  = "4096"
  cpus    = "2"

  inf_ny2_packer03 = {
    hostname = "${local.hostname_part}003"
    alias    = "${local.product}-${local.datacenter}-${local.facts.bt_role}03"
  }

}

module "inf_ny2_packer03" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = local.inf_ny2_packer03.hostname
  alias               = local.inf_ny2_packer03.alias
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

output "inf_ny2_packer03" {
  value = {
    "fqdn"  = module.inf_ny2_packer03.fqdn,
    "alias" = module.inf_ny2_packer03.alias,
    "ip"    = module.inf_ny2_packer03.ip,
  }
}
