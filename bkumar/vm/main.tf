#
# Building VMs for Testing
terraform {
  backend "s3" {}
}

locals {
  lob           = "BTIQ"
  product       = "afs"
  image         = "rhel8"
  environment   = "feature_BTIQ_77_jenkins"
  hostgroup     = "BTIQ Development"
  datacenter    = "ny2"
  cluster       = "ny2-aza-vmw-autolab"
  network       = "ny2-autolab-app"
  hostname_base = "us01vl"
  cpu           = "1"
  memory        = "4096"
  facts         = {
    "bt_product"       = "btiq"
    "bt_tier"          = "dev"
  }
  additional_disks     = {
      1 = "100",
  }
}

module "btiq-vmbox01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname_base}btiq${local.product}01"
  alias                = "btiq-vmbox01-${local.product}-01"
  lob                  = local.lob
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = local.cpu
  memory               = local.memory
  additional_disks     = local.additional_disks
}

output "btiq-vmbox01" {
  value = {
    "fqdn"  = module.btiq-vmbox01.fqdn,
    "alias" = module.btiq-vmbox01.alias,
    "ip"    = module.btiq-vmbox01.ip,
  }
}
