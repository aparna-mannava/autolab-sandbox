terraform {
  backend "s3" {}
}

locals {
  facts       = {
    "bt_product" = "pmx"
  }
}

module "vault_server_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlvlt01"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "PBS"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
}

output "vault_server_1" {
  value = {
    "fqdn"  = module.vault_server_1.fqdn,
    "alias" = module.vault_server_1.alias,
    "ip"    = module.vault_server_1.ip,
  }
}