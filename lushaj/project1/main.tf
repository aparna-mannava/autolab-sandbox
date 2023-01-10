terraform {
  backend "s3" {}
}

locals {
  environment    = "master"
  datacenter     = "ny2"
  hostgroup      = "BT Base Server"
  product	 = "BTC"
  facts          = {
    "bt_product" = "lushaj"
    "bt_tier"    = "dev"
    "bt_customer" = ""
  }
}

module "app_server_1" {
  source 		= "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname 		= "us01vltferin03"
  alias			= "ny2-dev-1"
  bt_infra_network      = "ny2-autolab-app-ahv"
  bt_infra_cluster      = "ny2-aze-ntnx-11"
  external_facts        = local.facts
  lob			= local.product
  os_version            = "rhel7"
  cpus                  = "4"
  memory                = "8192"
  foreman_environment   = local.environment
  foreman_hostgroup     = local.hostgroup
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

output "app_server_1" {
  value = {
    "fqdn"  = module.app_server_1.fqdn,
    "alias" = module.app_server_1.alias,
    "ip"    = module.app_server_1.ip,
  }
}

