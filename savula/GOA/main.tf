terraform {
  backend "http" {}
}

locals {
  lob           = "dgb"
  environment    = "master"
  datacenter    = "ny2"
  domain        = "auto.saas-n.com"
  facts         = {
    "bt_customer"         = "goa" #ex: fiXXXX
    "bt_product"          = "dgb"
    "bt_tier"             = "dev"
    "bt_env"              = "" #ex: leave blank for first env, or non-zero-padded number
    "bt_product_version"  = "3.6"
  }

  db1_hostname          = "us01vwdbsa1" #ex: us01vwdbXXX
  db1_alias             = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-db-001"
  db1_bt_infra_network  = "ny2-autolab-db-ahv"
  db1_bt_infra_cluster  = "ny2-aze-ntnx-11"
  db1_foreman_hostgroup = "BT Base Windows Server"

}
module "db_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.db1_hostname
  os_version           = "win2016"
  alias                = local.db1_alias
  datacenter           = local.datacenter
  bt_infra_network     = local.db1_bt_infra_network
  bt_infra_cluster     = local.db1_bt_infra_cluster
  foreman_environment  = local.environment
  foreman_hostgroup    = local.db1_foreman_hostgroup
  external_facts       = local.facts
  cpus                 = "4"
  memory               = "8192"
  additional_disks     = {
    1 = "100"
  }
}

output "host_file" {
  value = <<HOSTFILE

${module.db_server_1.ip}  db db001
  HOSTFILE
}

output "server_info" {
  value = <<INFO

||function||hostname||host alias||IP||
|db server 1|${module.db_server_1.fqdn}|${module.db_server_1.alias[0]}|${module.db_server_1.ip}|
  INFO
}
