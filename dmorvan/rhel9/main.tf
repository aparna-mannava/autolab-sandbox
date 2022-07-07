terraform {
  backend "s3" {}
}

locals {
  product     = "inf"
  environment = "master"
  hostname    = "gb00vlrhel9"
  hostgroup   = "BT Base Server"
  facts = {
    bt_product = "inf"
    bt_tier    = "pr"
    bt_role    = "base"
    bt_env     = "master"
  }
  datacenter = {
    name = "bunker"
    id   = "gb00"
  }
}

module "rhel9test" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.hostname}01"
  alias               = "${local.product}-${local.datacenter.id}-${local.facts.bt_role}01"
  bt_infra_cluster    = "gb00-azc-ntnx-02"
  bt_infra_network    = "gb00-saas-p-cea-services2"
  os_version          = "rhel9"
  cpus                = "2"
  memory              = "4096"
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter.name
}

output "rhel9test" {
  value = {
    "fqdn"  = module.rhel9test.fqdn,
    "alias" = module.rhel9test.alias,
    "ip"    = module.rhel9test.ip,
  }
}