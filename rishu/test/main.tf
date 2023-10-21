terraform {
  backend "s3" {}
}

locals {
  cluster        = "ny2-azb-ntnx-08"
  network        = "ny2-autolab-app-ahv"
  lob            = "PTX"
  cpus           = 4
  memory         = 16384
  os_version     = "rhel8"
  foreman_env    = "master"
  base_hostgroup = "BT Base Server"
  dc             = "ny2"
  external_facts = {
    bt_product   = "ptx"
    bt_tier      = "autolab"
    bt_services_running = "disabled"
  }
  additional_disks = {
    1 = "30", 
    2 = "20",
    3 = "100"
  }
}

module "tst01" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vllvmtst01"
  alias               = "ptx-${local.external_facts.bt_tier}-lvm-tst-01"
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  cpus                = local.cpus
  lob                 = local.lob
  memory              = local.memory
  external_facts      = local.external_facts
  os_version          = local.os_version
  foreman_environment = local.foreman_env
  foreman_hostgroup   = local.base_hostgroup
  datacenter          = local.dc
  additional_disks    = local.additional_disks
}

output "tst01" {
  value = {
    "fqdn"  = module.tst01.fqdn,
    "alias" = module.tst01.alias,
    "ip"    = module.tst01.ip,
  }
}