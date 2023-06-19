terraform {
  backend "s3" {}
}

locals {
  product     = "inf"
  datacenter  = "ny2"
  lob         = "CLOUD"
  environment = "master"
  facts = {
    "bt_product" = "inf",
  }
}

module "mg-test-server" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=feature/CLOUD-123517"
  hostname            = "us01vlinuxmg01"
  bt_infra_cluster    = "ny5-aza-ntnx-19"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel8"
  foreman_environment = local.environment
  foreman_hostgroup   = "BT Base Server"
  datacenter          = local.datacenter
  lob                 = local.lob
  cpus                = "2"
  memory              = "2048"
  external_facts      = local.facts

  additional_disks = {
    1 = "20"
  }
}
output "mg-test-server" {
  value = {
    "fqdn"  = module.mg-test-server.fqdn,
    "ip"    = module.mg-test-server.ip,
  }
}