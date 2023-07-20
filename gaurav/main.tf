terraform {
  backend "s3" {}
}

locals {
  lob = "CLOUD"
  environment = "master"
  datacenter  = "ny2"
  network     = "ny2-autolab-app-ahv"
  cluster     = "ny2-azb-ntnx-08"
  facts       = {
    "bt_product"   = "sre"
  }
}

module "us01vwnxsre03" {
source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
hostname            = "us01vwnxsre03"
bt_infra_cluster    = local.cluster
bt_infra_network    = local.network
cpus                = 4
lob                 = local.lob
memory              = 8192
os_version          = "win2019"
foreman_environment = local.environment
foreman_hostgroup   = "BT Base Windows Server"
datacenter          = local.datacenter
}

output "us01vwnxsre03" {
value = {
"fqdn"  = module.us01vwnxsre03.fqdn,
"alias" = module.us01vwnxsre03.alias,
"ip"    = module.us01vwnxsre03.ip,
}
}
#