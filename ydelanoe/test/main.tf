terraform {
  backend "s3" {}
}

locals {
  lob           = "FMCLOUD"
  environment   = "master"
  hostgroup     = "BT Base Windows Server"
  image         = "win2019"
  cluster         = "ny2-azb-ntnx-08"
  network         = "ny2-autolab-app-ahv"
  datacenter      = "ny2"
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "ch-dev"
    "bt_hostlink.one"   = "titi"
    "bt_hostlink.two"   = "toto"
  }
}

module "test" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "ydel1"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "1"
  memory               = "2048"
  lob                  = local.lob
}

output "test" {
  value = {
    "fqdn"  = module.test.fqdn,
    "alias" = module.test.alias,
    "ip"    = module.test.ip,
  }
}
