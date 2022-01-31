terraform {
  backend "s3" {}
}
 
locals {
  product     = "cfrm"
  environment = "master"
  datacenter  = "ny2"
  hostname       = "us01vwmkms2019"
  hostgroup      = "BT MSSQL 2019 Server"
  facts       = {
    "bt_tier" = "dev"
    "bt_env"  = "1"
    "bt_product" = "cfrm"
    "bt_role"         = "mssql"
  }
}
 
module "app_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.hostname}"
  alias                = ""
  bt_infra_network     ="ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  lob                  = "CLOUD"
  os_version           = "win2019"
  cpus                 = "4"
  memory               = "8192"
  external_facts       = "${local.facts}"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

output "app_server_1" {
  value = {
    "fqdn"  = "${module.app_server_1.fqdn}",
    "alias" = "${module.app_server_1.alias}",
    "ip"    = "${module.app_server_1.ip}",
  }
}