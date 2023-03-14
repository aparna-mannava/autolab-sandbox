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

module "dmts05" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=feature/CLOUD-119870"
  hostname            = "us01vldmts05"
  alias               = "dmts-ts-05"
  bt_infra_cluster    = "ny5-aza-ntnx-14"
  bt_infra_network    = "ny2-autolab-app-ahv"
  cpus                = 2
  lob                 = "CLOUD"
  memory              = 4096
  os_version          = "rhel9"
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = "ny2"
}

output "dmts05" {
  value = {
    "fqdn"  = module.dmts05.fqdn,
    "alias" = module.dmts05.alias,
    "ip"    = module.dmts05.ip,
  }
}