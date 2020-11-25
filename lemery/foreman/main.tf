# blargh
terraform {
  backend "s3" {}
}

locals {
  lob           = "cea"
  image         = "rhel7"
  hostgroup     = "BT Base Server"
  environment   = "master"
  datacenter    = "ny2"
  cluster       = "ny2-aza-ntnx-13"
  network       = "ny2-autolab-app-ahv"
  cpus          = "4"
  memory        = "16384"
  disks     = {
    1 = "60",
    2 = "500",
  }
  facts         = {
    "bt_product"      = "cloud"
    "bt_role"         = "foreman_server"
  }
}

module "foreman_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlf01"
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
  lob                  = local.lob
}

output "foreman_server_1" {
  value = {
    "fqdn"  = "${module.foreman_server_1.fqdn}",
    "alias" = "${module.foreman_server_1.alias}",
    "ip"    = "${module.foreman_server_1.ip}",
  }
}

