terraform {
  backend "s3" {}
}

locals {
  product     = "cfrm"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_product"         = "cfrm"
    "bt_customer"        = "bfs"
    "bt_tier"            = "prod"
    "bt_env"             = "1"
    "bt_role"            = "oradb"
    "bt_deployment_mode" = "live"
    "bt_infra_network"   = "ny2-autolab-app-ahv"
    "bt_infra_cluster"   = "ny5-aza-ntnx-19"
    "db_memory"          = "4096"
    "obs_memory"         = "4096"
    "db_cpus"            = "4"
    "obs_cpus"           = "2"
    "os_version"         = "rhel7"
    "db01_hostname"      = "us01vldbsdp56"
​    "db02_hostname"      = "us01vldbsdp57"
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
    "bt_alias" = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-db56-${local.facts.bt_deployment_mode}"
    "bt1_alias" = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-db57-${local.facts.bt_deployment_mode}"
  }
}
​
module "oradb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.db01_hostname}"
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.db01facts.bt_server_mode}db56-${local.facts.bt_deployment_mode}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  os_version           = "${local.facts.os_version}"
  cpus                 = "${local.facts.db_cpus}"
  memory               = "${local.facts.db_memory}"
  lob                  = "CFRM"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT CFRM SP Oracle19c Server"
  datacenter           = local.datacenter
  external_facts       = local.db01facts
  additional_disks     = {
    1 = "200",
    2 = "100",
    3 = "100",
    4 = "100"
  }
}

module "oradb_server_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.db02_hostname}"
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.db01facts.bt_server_mode}db57-${local.facts.bt_deployment_mode}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  os_version           = "${local.facts.os_version}"
  cpus                 = "${local.facts.db_cpus}"
  memory               = "${local.facts.db_memory}"
  lob                  = "CFRM"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT CFRM SP Oracle19c Server"
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

output "oradb_server_2" {
  value = {
    "fqdn"  = "${module.oradb_server_2.fqdn}",
    "alias" = "${module.oradb_server_2.alias}",
    "ip"    = "${module.oradb_server_2.ip}",
  }
}
