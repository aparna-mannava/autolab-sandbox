#
# Building VMs for Testing

terraform {
  backend "http" {}
}

locals {
  environment    = "master"
  hostgroup      = "BT Base Server"
  datacenter     = "ny2"
  image          = "rhel7"
  network        = "ny2-autolab-app-ahv"
  cluster        = "ny2-azd-ntnx-10"
  facts          = {
    "bt_product"       = "btiq"
    "bt_tier"          = "dev"
  }
}

module "btiq-vm01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlbtivm01"
  alias                = "btiq-vm01"
  bt_infra_network     = local.network
  bt_infra_cluster     = local.cluster
  os_version           = local.image
  cpus                 = "2"
  memory               = "4000"
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "100"
  }
}

output "btiq-vm01" {
  value = {
    "fqdn"  = "${module.btiq-vm01.fqdn}",
    "alias" = "${module.btiq-vm01.alias}",
    "ip"    = "${module.btiq-vm01.ip}",
  }
}
