terraform {
  backend "s3" {}
}

locals {
  product     = "inf"
  environment = "cloud-104535"
  datacenter  = "ny2"
  facts = {
    "bt_tier" = "ny2"
    "bt_product" = "cloud"
  }
}

module "autolab-squid-1" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01v1squid01"
  alias               = "autolab-poc-sq01"
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel8"
  cpus                = "2"
  lob                 = "CLOUD"
  memory              = "8192"
  foreman_environment = local.environment
  foreman_hostgroup   = "BT Base Server"
  datacenter          = local.datacenter
  external_facts      = local.facts
}

output "autolab-squid-1" {
  value = {
    "fqdn"  = module.autolab-squid-1.fqdn,
    "alias" = module.autolab-squid-1.alias,
    "ip"    = module.autolab-squid-1.ip,
  }
}


module "autolab-squid-2" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01v1squid02"
  alias               = "autolab-poc-sq02"
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel8"
  cpus                = "2"
  lob                 = "CLOUD"
  memory              = "8192"
  foreman_environment = local.environment
  foreman_hostgroup   = "BT Base Server"
  datacenter          = local.datacenter
  external_facts      = local.facts
}

output "autolab-squid-2" {
  value = {
    "fqdn"  = module.autolab-squid-2.fqdn,
    "alias" = module.autolab-squid-2.alias,
    "ip"    = module.autolab-squid-2.ip,
  }
}
