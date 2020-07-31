terraform {
  backend "s3" {}
}

locals {
  facts       = {
    "bt_product" = "inf"
  }
}

module "wintf_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CLOUD-67012-Windows-Waits"
  hostname             = "us01vwtft00101"
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



module "nixtf_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CLOUD-67012-Windows-Waits"
  hostname             = "us01vltft00101"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "INF"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}


output "wintf_server_1" {
  value = {
    "fqdn"  = "${module.wintf_server_1.fqdn}",
    "alias" = "${module.wintf_server_1.alias}",
    "ip"    = "${module.wintf_server_1.ip}",
  }
}

output "nixtf_server_1" {
  value = {
    "fqdn"  = "${module.nixtf_server_1.fqdn}",
    "alias" = "${module.nixtf_server_1.alias}",
    "ip"    = "${module.nixtf_server_1.ip}",
  }
}

