terraform {
  backend "s3" {}
}

locals {
  datacenter  = "ny2"
  os          = "rhel8"
  cpus        = "2"
  ram         = "4096"
  network     = "ny2-autolab-app-ahv"
  cluster     = "ny2-aza-ntnx-07"
  hostgroup   = "BT CLOUD Bitwarden Server"
  hostname    = "us01vlbwpw001"
  alias       = "cloud-ny2-bitwarden01"
  lob         = "CLOUD"
  environment = "feature_CLOUD_88029_create_bitwarden_poc"
  facts = {
    bt_product = "cloud"
    bt_role    = "bitwarden"
    bt_tier    = "lab"
  }
  disks = {
    1 = "50"
  }
}

module "patch-test" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=feature/CLOUD-88446_terraform_upgrade"
  lob                 = local.lob
  hostname            = local.hostname
  alias               = local.alias
  cpus                = local.cpus
  memory              = local.ram
  os_version          = local.os
  foreman_hostgroup   = local.hostgroup
  foreman_environment = local.environment
  bt_infra_cluster    = local.cluster
  bt_infra_network    = local.network
  datacenter          = local.datacenter
  external_facts      = local.facts
  additional_disks    = local.disks
}

output "patch-test" {
  value = {
    fqdn  = module.patch-test.fqdn
    alias = module.patch-test.alias
    ip    = module.patch-test.ip
  }
}
