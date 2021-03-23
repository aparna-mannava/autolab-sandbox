terraform {
  backend "s3" {}
}

locals {
  image         = "rhel7"
  hostgroup     = "BT Base Server"
  environment   = "feature_CEA_10101_confluent_control_center"
  datacenter    = "ny2"
  cluster       = "ny5-azd-ntnx-15"
  network       = "ny2-autolab-app-ahv"
  cpus          = "4"
  memory        = "2048"
  disks     = {
    1 = "500",
  }
  facts         = {
    "bt_product"      = "inf"
    "bt_role"         = "kafka_control_center"
  }
}

module "base_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlskfkcc100"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  cpus                 = local.cpus
  memory               = local.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  additional_disks     = local.disks
  lob                  = "CEA"
}

output "base_server_1" {
  value = {
    "fqdn"  = "${module.base_server_1.fqdn}",
    "alias" = "${module.base_server_1.alias}",
    "ip"    = "${module.base_server_1.ip}",
  }
}
