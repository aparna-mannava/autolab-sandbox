terraform {
  backend "s3" {}
}

locals {
  lob = "CLOUD"
  environment = "master"
  datacenter  = "ny2"
  network = "ny2-autolab-app-ahv"
  cluster = "ny5-azd-ntnx-27"
}

module "us01vlpromextst" {
  source = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname = "us01vlpromextst"
  bt_infra_cluster = local.cluster
  bt_infra_network = local.network
  lob = local.lob
  os_version = "rhel8"
  cpus = "4"
  memory = "4096"
  foreman_environment = local.environment
  foreman_hostgroup = "BT Base Server"
  datacenter = local.datacenter
  }

output "us01vlpromextst" {
  value = {
    "fqdn"  = module.us01vlpromextst.fqdn,
    "ip"    = module.us01vlpromextst.ip,
  }
}