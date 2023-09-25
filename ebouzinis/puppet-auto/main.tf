terraform {
  backend "s3" {}
}

locals {
  lob           = "CLOUD"
  environment   = "feature_CLOUD_126872"
  hostgroup     = "BT Base Server"
  image         = "rhel8"
  cluster         = "ny2-azb-ntnx-08"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  facts         = {
    "bt_product"        = "CLOUD"
    "bt_tier"           = "inf"
  }
}

module "test" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlebtst123"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "2"
  memory               = "4096"
  lob                  = "CLOUD"
}

output "test" {
  value = {
    "fqdn"  = module.test.fqdn,
    "alias" = module.test.alias,
    "ip"    = module.test.ip,
  }
}
