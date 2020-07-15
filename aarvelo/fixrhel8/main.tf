terraform {
  backend "http" {}
}

locals {
  facts       = {
    "bt_product" = "inf"
  }
}

module "fixrhel8_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfix8001"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "INF"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel8"
  foreman_environment  = "hotfix_CLOUD_67123_Fix_RHEL8_Updates"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

output "fixrhel8_server_1" {
  value = {
    "fqdn"  = "${module.fixrhel8_server_1.fqdn}",
    "alias" = "${module.fixrhel8_server_1.alias}",
    "ip"    = "${module.fixrhel8_server_1.ip}",
  }
}
