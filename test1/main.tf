# Nexus and Yum repo vm for Dev environment #

terraform {
  backend "s3" {}
}
locals {
  lob           = "dgb"
  puppet_env    = "local.puppet_env"
  datacenter    = "ny2"
  facts         = {
    "bt_customer"         = "shared" #ex: fiXXXX
    "bt_tier"             = "dev" #ex: sbx, tst, td, demo
    "bt_env"              = "" #ex: leave blank for first env, or non-zero-padded number
    "bt_product_version"  = ""
    "bt_product"          = "dgb"
  }
}
module "repo_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01infratest01"
  bt_infra_environment = "ny2-autolab-app"
  os_version           = "rhel7"
  alias                = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-repo01"
  cpus                 = "4"
  memory               = "6144"
  foreman_environment  = "local.puppet_env"
  foreman_hostgroup    = "BT DGB Generic Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
    2 = "60"
}
}


output "repo_server_1" {
  value = <<INFO

||function||hostname||host alias||IP||
|repo_server_1|${module.repo_server_1.fqdn}|${module.repo_server_1.alias[0]}|${module.repo_server_1.ip}|
  INFO
}