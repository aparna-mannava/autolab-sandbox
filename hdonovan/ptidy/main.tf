terraform {
  backend "s3" {}
}

locals {
  image         = "rhel7"
  hostgroup     = "BT FML Linux Server Build Test"
  environment   = "master"
  datacenter    = "ny2"
  cluster       = "ny2-azb-ntnx-09"
  network       = "ny2-autolab-app-ahv"
  cpus          = "2"
  memory        = "2048"
  disks     = {
    1 = "20",
  }
  facts         = {
    "bt_product"      = "fml"
    "bt_tier"         = "autolab"
  }
  lob         = "fml"
}

module "tidy_test_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlhdpt001"
  alias                = "fml-ny2-hdpttest001"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  additional_disks     = local.disks
  external_facts       = local.facts
  lob                  = local.lob
}

output "tidy_test_server_1" {
  value = {
    "fqdn"  = module.tidy_test_server_1.fqdn,
    "alias" = module.tidy_test_server_1.alias,
    "ip"    = module.tidy_test_server_1.ip,
  }
}
