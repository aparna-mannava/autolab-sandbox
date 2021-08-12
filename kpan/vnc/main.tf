terraform {
  backend "s3" {}
}

locals {
  tier            = "auto"
  bt_env          = "1"
  bt_product      = "btiq"
  facts = {
    "bt_env"                  = local.bt_env
    "bt_tier"                 = local.tier
    "bt_product"              = local.bt_product
  }
}

module "vnc-vm" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vwbtiqvn001"
  bt_infra_network    = "ny2-autolab-app-ahv"
  bt_infra_cluster    = "ny5-aza-ntnx-19"
  os_version          = "win2016"
  foreman_environment = "master"
  foreman_hostgroup   = "BT Base Windows Server"
  datacenter          = "ny2"
  lob                 = "CLOUD"
  cpus                = "1"
  memory              = "4096"
  additional_disks = {
    1 = "100"
  }
  external_facts = local.facts
}

output "vnc-vm" {
  value = {
    "fqdn"  = module.vnc-vm.fqdn,
    "ip"    = module.vnc-vm.ip,
  }
}