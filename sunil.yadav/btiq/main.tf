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

module "datascience-vm" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlbtiqds006"
  bt_infra_network    = "ny2-autolab-app-ahv"
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  alias               = "btiq-${local.facts.bt_tier}${local.facts.bt_env}-ds05"
  os_version          = "rhel8"
  foreman_environment = "master"
  foreman_hostgroup   = "BT Base Server"
  datacenter          = "ny2"
  lob                 = "btiq"
  cpus                = "2"
  memory              = "10240"
  additional_disks = {
    1 = "200"
  }
  external_facts = local.facts
}
output "datascience-vm" {
  value = {
    "fqdn"  = module.datascience-vm.fqdn,
    "alias" = module.datascience-vm.alias,
    "ip"    = module.datascience-vm.ip,
  }
}
