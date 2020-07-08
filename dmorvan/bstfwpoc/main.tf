terraform {
  backend "http" {}
}

locals {
  product     = "inf"
  environment = "master"
  datacenter  = "ny2"
  hostgroup   = "BT Base Server"
  facts = {
    "bt_product" = "inf"
    "bt_role"    = "bstn"
    "bt_tier"    = "test"
  }
}

module "bstfwpoc" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlbtsts001"
  alias               = "${local.product}-${local.datacenter}-${local.facts.bt_role}002"
  bt_infra_cluster    = "ny2-aza-vmw-autolab"
  bt_infra_network    = "ny2-autolab-app"
  lob                 = "CLOUD"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "2048"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter}"
}

output "bstfwpoc" {
  value = {
    "fqdn"  = "${module.bstfwpoc.fqdn}",
    "alias" = "${module.bstfwpoc.alias}",
    "ip"    = "${module.bstfwpoc.ip}",
  }
}
