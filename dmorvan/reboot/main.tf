terraform {
  backend "s3" {}
}
locals {
  product     = "inf"
  environment = "master"
  hostgroup   = "BT Base Server"
  facts = {
    bt_product = "inf"
    bt_role    = "base"
    bt_env     = "master"
    bt_tier    = "dev"
  }
}

module "rbt01" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlrbt01"
  alias               = "dmts-rbt-01"
  bt_infra_cluster    = "ny5-azg-ntnx-25"
  bt_infra_network    = "ny2-autolab-app-ahv"
  cpus                = 2
  lob                 = "CLOUD"
  memory              = 4096
  os_version          = "rhel8"
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = "ny2"
}

output "rbt01" {
  value = {
    "fqdn"  = module.rbt01.fqdn,
    "alias" = module.rbt01.alias,
    "ip"    = module.rbt01.ip,
  }
}