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
    "bt_role"    = "os-test"
    "bt_tier"    = "test"
  }
}

module "tfm_disallow_os" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CLOUD-42776_allow_os"
  hostname            = "us01vltfmts002"
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

output "tfm_disallow_os" {
  value = {
    "fqdn"  = "${module.tfm_disallow_os.fqdn}",
    "alias" = "${module.tfm_disallow_os.alias}",
    "ip"    = "${module.tfm_disallow_os.ip}",
  }
}