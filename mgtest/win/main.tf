terraform {
  backend "s3" {}
}

locals {
  product     = "inf"
  datacenter  = "ny2"
  lob         = "CLOUD"
  environment = "master"
  facts       = {
    "bt_product" = "inf",
  }
}

module "mg-win-srv" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=feature/CLOUD-111117-test-nutanix-vm"
  hostname             = "us01vwin16"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "win2016"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  lob                  = local.lob
  cpus                 = "4"
  memory               = "8192"
  external_facts       = local.facts

  additional_disks     = {
    1 = "50"
  }
}
output "mg-win-srv" {
  value = {
    "fqdn"  = "${module.mg-win-srv.fqdn}",
    "alias" = "${module.mg-win-srv.alias}",
    "ip"    = "${module.mg-win-srv.ip}",
  }
}