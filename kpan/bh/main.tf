terraform {
  backend "s3" {}
}

locals {
  bt_product      = "inf"
  facts = {
    "bt_product"              = local.bt_product
  }
}

module "vnc-vm" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vwbtiqbh001"
  bt_infra_network    = "ny2-autolab-app-ahv"
  bt_infra_cluster    = "ny5-aza-ntnx-19"
  os_version          = "win2016"
  foreman_environment = "master"
  foreman_hostgroup   = "BT Windows Bastion Hosts"
  datacenter          = "ny2"
  lob                 = "BTIQ"
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