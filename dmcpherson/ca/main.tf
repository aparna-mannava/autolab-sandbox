terraform {
  backend "s3" {}
}
#decom
locals {
  lob        = "CFRM"
  product     = "cfrm"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "sbx"
    "bt_product" = "cfrm"
    "bt_env"  = ""
  }
}

module "ca_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlca1000"
  alias                = "cfrm-autolab-sbx-ca01"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  lob                   = "CFRM"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "50",
    3 = "200"
  }
}

output "ca_server_1" {
  value = {
    "fqdn"  = module.ca_server_1.fqdn,
    "alias" = module.ca_server_1.alias,
    "ip"    = module.ca_server_1.ip,
  }
}