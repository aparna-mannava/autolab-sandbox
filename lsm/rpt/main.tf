terraform {
  backend "http" {}
}

locals {
  lob                  = "LSM"
  product              = "lx"
  image                = "rhel7"
  hostgroup            = "BT LX Reporting Server"
  environment          = "nonprod"
  datacenter           = "ny2"
  cluster              = "ny2-aze-ntnx-11"
  network              = "ny2-autolab-app-ahv"
  cpus_num             = "2"
  mem_mb               = "2048"
  hostname_base        = "us01vl"
  facts                = {
    "bt_product"       = "lx"
    "bt_tier"          = "auto"
    "bt_env"           = "8"
    "bt_overide_date"  = "false"
    "bt_customer"      = ""
    "bt_role"          = "rpt"
    "bt_lob"           = "LSM"
  }
  disks                = {
    1                  = "200"
  }
}

module "rpt01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlsmrpt01"
  alias                = "lsm-rpt01"

  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  lob                  = local.lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = local.disks
  cpus                 = local.cpus_num
  memory               = local.mem_mb
}

output "rpt01" {
  value                = {
    "fqdn"             = module.rpt01.fqdn,
    "alias"            = module.rpt01.alias
  }
}

