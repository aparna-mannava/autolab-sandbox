terraform {
  backend "s3" {}
}

locals {
  lob           = "dgb"
  puppet_env    = "feature_FMDO_2117_vm_provisionning_for_gtsuite_on_saas_n"
  datacenter    = "ny2"
  domain        = "saas-n.com"
  facts         = {
    "bt_customer"         = "fi1200" #ex: fiXXXX
    "bt_tier"             = "dev"
    "bt_env"              = "3" #ex: leave blank for first env, or non-zero-padded number
  }

  db_hostname            = "us01vlfmgora01" 
  db_alias               = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-oradb01"
  db_bt_infra_network    = "ny2-autolab-app-ahv"
  db_bt_infra_cluster    = "ny2-aza-ntnx-13"
  db_foreman_hostgroup   = "BT DGB Oradb Server"
}


module "db_server" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.db_hostname
  os_version           = "rhel7"
  alias                = local.db_alias
  datacenter           = local.datacenter
  bt_infra_network     = local.db_bt_infra_network
  bt_infra_cluster     = local.db_bt_infra_cluster
  lob                  = "FMCLOUD"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = local.db_foreman_hostgroup
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "65536"
  additional_disks     = {
    1 = "200",
    2 = "200",
    3 = "200"
  }
}

output "host_file" {
  value = <<HOSTFILE
${module.db_server.ip}  db
  HOSTFILE
}

output "server_info" {
  value = <<INFO

||function||hostname||host alias||IP||
|database|${module.db_server.fqdn}|${module.db_server.alias[0]}|${module.db_server.ip}|
  INFO
}
