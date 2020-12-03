terraform {
  backend "s3" {}
}

locals {
  lob           = "cea"
  image         = "rhel7"
  hostgroup     = "BT Base Server"
  environment   = "feature_CEA_6213_k8s_svc_ip_ranges"
  datacenter    = "ny2"
  cluster       = "ny2-aza-ntnx-05"
  network       = "ny2-autolab-app-ahv"
  cpus          = "4"
  memory        = "4096"
  disks     = {
    1 = "100",
  }
  facts         = {
    "bt_product"      = "inf"
    "bt_tier"         = "autolab"
    "bt_env"          = "94"
  }
}

module "base_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlkw007"
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

module "base_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlkw008"
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

output "base_server_1" {
  value = {
    "fqdn"  = "${module.base_server_1.fqdn}",
    "alias" = "${module.base_server_1.alias}",
    "ip"    = "${module.base_server_1.ip}",
  }
}

output "base_server_2" {
  value = {
    "fqdn"  = "${module.base_server_2.fqdn}",
    "alias" = "${module.base_server_2.alias}",
    "ip"    = "${module.base_server_2.ip}",
  }
}

