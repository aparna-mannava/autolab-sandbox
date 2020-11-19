terraform {
  backend "http" {}
}

locals {
  lob           = "cea"
  image         = "rhel7"
  hostgroup     = "BT Base Server"
  environment   = "master"
  datacenter    = "ny2"
  cluster       = "ny2-aza-ntnx-05"
  network       = "ny2-autolab-app-ahv"
  cpus          = "4"
  memory        = "2048"
  disks     = {
    1 = "60",
    2 = "500",
  }
  facts         = {
    "bt_product"      = "cloud"
    "bt_role"         = "foo"
    "bt_tier"         = "pr"
  }
}

module "base_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfac01"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = local.disks
}

output "base_server_1" {
  value = {
    "fqdn"  = "${module.base_server_1.fqdn}",
    "alias" = "${module.base_server_1.alias}",
    "ip"    = "${module.base_server_1.ip}",
  }
}

