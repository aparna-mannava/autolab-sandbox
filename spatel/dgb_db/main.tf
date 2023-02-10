terraform {
  backend "s3" {}
}

locals {
  product     = "cfrm"
  environment = "feature_CLOUD_116758"
  datacenter  = "ny2"
  facts       = {
    "bt_product"         = "cfrm"
    "bt_customer"        = "bfs"
    "bt_tier"            = "prod"
    "bt_env"             = "1"
    "bt_role"            = "oradb"
    "bt_deployment_mode" = "live"
    "bt_infra_network"   = "ny2-autolab-app-ahv"
    "bt_infra_cluster"   = "ny5-aza-ntnx-14"
    "db_memory"          = "4096"
    "obs_memory"         = "4096"
    "db_cpus"            = "4"
    "obs_cpus"           = "2"
    "os_version"         = "rhel7"
    "db01_hostname"      = "us01vlautdbs30"


  }
  db01facts    = {
    "bt_product" = "${local.facts.bt_product}"
    "bt_customer" = "${local.facts.bt_customer}"
    "bt_tier" = "${local.facts.bt_tier}"
    "bt_role" = "${local.facts.bt_role}"
    "bt_env" = "${local.facts.bt_env}"
    "bt_server_mode" = "db"
    "bt_server_number" = "84"
    "bt_deployment_mode" = "${local.facts.bt_deployment_mode}"
    "bt_alias" = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-bs30-${local.facts.bt_deployment_mode}"
  }
}

module "oradb_server_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.db01_hostname}"
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.db01facts.bt_server_mode}${local.db01facts.bt_server_number}-${local.facts.bt_deployment_mode}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  os_version           = "${local.facts.os_version}"
  cpus                 = "${local.facts.db_cpus}"
  memory               = "${local.facts.db_memory}"
  lob                  = "CFRM"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
  datacenter           = local.datacenter
  external_facts       = local.db01facts
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100",
    4 = "100"
  }
}


output "oradb_server_1" {
  value = {
    "fqdn"  = "${module.oradb_server_1.fqdn}",
    "alias" = "${module.oradb_server_1.alias}",
    "ip"    = "${module.oradb_server_1.ip}",
  }
}