terraform {
  backend "s3" {}
}

locals {
  product     = "cfrm"
  environment = "feature_CLOUD_109889"
  datacenter  = "ny2"
  facts       = {
    "bt_product"         = "cfrm"
    "bt_customer"        = "varo"
    "bt_tier"            = "sbx"
    "bt_env"             = "1"
    "bt_role"            = "oradb"
  }
  facts_2     = {
    "bt_product"         = "cfrm"
    "bt_customer"        = "varo"
    "bt_tier"            = "prod"
    "bt_env"             = "1"
    "bt_role"            = "oradb"
  }
  facts_3     = {
    "bt_product"         = "cfrm"
    "bt_customer"        = "varo"
    "bt_tier"            = "dr"
    "bt_env"             = "1"
    "bt_role"            = "oradb"
  }
}

module "cfrm_dbserver_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmsbx25"
  alias                = "${local.product}-${local.facts.bt_customer}-${local.facts.bt_tier}25"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

module "cfrm_dbserver_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmsbx26"
  alias                = "${local.product}-${local.facts_2.bt_customer}-${local.facts_2.bt_tier}26"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts_2
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

module "cfrm_dbserver_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmsbx27"
  alias                = "${local.product}-${local.facts_3.bt_customer}-${local.facts_3.bt_tier}27"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  lob                  = "CLOUD"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.facts_3
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
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

output "cfrm_dbserver_3" {
  value = {
    "fqdn"  = module.cfrm_dbserver_3.fqdn,
    "alias" = module.cfrm_dbserver_3.alias,
    "ip"    = module.cfrm_dbserver_3.ip
  }
}
