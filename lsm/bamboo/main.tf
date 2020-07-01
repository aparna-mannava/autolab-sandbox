
terraform {
  backend "http" {}
}

locals {
  lob                  = "LSM"
  product              = "lsm"
  image                = "rhel7"
  hostgroup            = "BT Base Server"
  environment          = "master"
  datacenter           = "ny2"
  cluster              = "ny2-aza-vmw-autolab"
  network              = "ny2-autolab-app"
  cpu                  = "2"
  memory               = "8192"

  disks                = {
    1                  = "200"
    2                  = "100"
    3                  = "300"
    4                  = "300"
    5                  = "300"
  }

  facts                = {
    "bt_product"       = "lsm"
    "bt_tier"          = "auto"
    "bt_env"           = "1"
    "bt_overide_date"  = "false"
    "bt_lob"           = "LSM"
    "bt_role"          = "bamboo_master"
  }
}

module "bamboo_master" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlsmbmbm"
  alias                = "lsm-bamboo01"
  os_version           = local.image
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  external_facts       = local.facts
  cpus                 = local.cpu
  memory               = local.memory
  additional_disks     = local.disks
}

output "bamboo_master" {
  value                = {
    "fqdn"             = module.bamboo_master.fqdn,
    "alias"            = module.bamboo_master.alias,
    "ip"               = module.bamboo_master.ip,
  }
}

