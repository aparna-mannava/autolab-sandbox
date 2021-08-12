terraform {
  backend "s3" {}
}

locals {
  facts = {
    "bt_tier"        = "dev"
    "bt_product"     = "btiq"
    "bt_env"         = ""
  }
}

module "vnc-vm" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlbtiqvnc01"
  bt_infra_network    = "ny2-autolab-app-ahv"
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  alias               = "btiq-${local.facts.bt_tier}${local.facts.bt_env}-vnc01"
  os_version          = "win2016"
  foreman_environment = "master"
  foreman_hostgroup   = "BT Base Windows Server"
  datacenter          = "ny2"
  lob                 = "btiq"
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
    "alias" = module.vnc-vm.alias,
    "ip"    = module.vnc-vm.ip,
  }
}