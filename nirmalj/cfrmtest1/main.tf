terraform {
  backend "s3" {}
}

locals {
  product     = "cfrm"
  environment = "feature_CLOUD_98510"
  datacenter  = "ny2"
  facts       = {
    "bt_product"         = "cfrm"
    "bt_customer"        = "varo"
    "bt_tier"            = "sbx"
    "bt_env"             = "1"
    "bt_role"            = "oradb"
    "bt_em_agent"        = "13.4.0.0"
  }
}

module "cfrm_dbserver_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmsbx77"
  alias                = "${local.product}-${local.facts.bt_customer}-${local.facts.bt_tier}77"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT CFRM SP Oracle Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100"
  }
}

module "cfrm_dbserver_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmsbx78"
  alias                = "${local.product}-${local.facts.bt_customer}-${local.facts.bt_tier}78"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT CFRM SP Oracle Secondary Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100"
  }
}


output "cfrm_dbserver_1" {
  value = {
    "fqdn"  = module.cfrm_dbserver_1.fqdn,
    "alias" = module.cfrm_dbserver_1.alias,
    "ip"    = module.cfrm_dbserver_1.ip
  }
}

output "cfrm_dbserver_2" {
  value = {
    "fqdn"  = module.cfrm_dbserver_2.fqdn,
    "alias" = module.cfrm_dbserver_2.alias,
    "ip"    = module.cfrm_dbserver_2.ip
  }
}