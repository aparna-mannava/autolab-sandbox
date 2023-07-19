terraform {
  backend "s3" {}
}

locals {
  lob         = "CLOUD"
  product     = "dgb"
  environment = "master"
  datacenter  = "ny2"
  facts         = {
    "bt_tier"             = "demo" #ex: sbx, tst, td, demo
    "bt_env"              = "1" #ex: leave blank for first env, or non-zero-padded number
  }
}

module "cloud_pgserver_4" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldmpg04"
  alias                = "tf-pg-dm-p004"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Postgresql DB Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "100",
    2 = "100",
    3 = "100"
  }
}


output "cloud_pgserver_4" {
  value = {
    "fqdn"  = module.cloud_pgserver_4.fqdn,
    "alias" = module.cloud_pgserver_4.alias,
    "ip"    = module.cloud_pgserver_4.ip,
  }
}