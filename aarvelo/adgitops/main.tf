terraform {
  backend "http" {}
}

locals {
  facts       = {
    "bt_product" = "inf"
  }
}

module "adgitops_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwadops01"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "INF"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "win2016"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Windows Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

output "adgitops_server_1" {
  value = {
    "fqdn"  = "${module.adgitops_server_1.fqdn}",
    "alias" = "${module.adgitops_server_1.alias}",
    "ip"    = "${module.adgitops_server_1.ip}",
  }
}
