
terraform {
  backend "s3" {}
}


locals {
  lob                  = "LSM"
  product              = "lsm"
  image                = "rhel7"
  hostgroup            = "BT Base Server"
  environment          = "master"
  datacenter           = "ny2"
  cluster              = "ny2-aza-ntnx-13"
  network              = "ny2-autolab-app-ahv"
  cpu                  = "2"
  memory               = "8192"

  disks                = {
    1                  = "200"
    2                  = "100"
  }

  facts                = {
    "bt_product"       = "lsm"
    "bt_tier"          = "auto"
    "bt_env"           = "1"
    "bt_overide_date"  = "false"
    "bt_lob"           = "LSM"
    "bt_role"          = ""
  }
}

module "pup01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlspup"
  alias                = "lsm-pup01"
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

output "pup01" {
  value                = {
    "fqdn"             = module.pup01.fqdn,
    "alias"            = module.pup01.alias,
    "ip"               = module.pup01.ip,
  }
}

