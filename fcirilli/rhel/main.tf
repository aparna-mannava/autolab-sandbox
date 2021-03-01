#DELETE PLAN

terraform {
  backend "s3" {}
}

locals {
  lob           = "fmcloud"
  puppet_env    = "feature_FMDO_2117_vm_provisionning_for_gtsuite_on_saas_n"
  datacenter    = "ny2"
  domain        = "saas-n.com"
  facts         = {
    "bt_customer"         = "fi1200" #ex: fiXXXX
    "bt_tier"             = "dev"
    "bt_env"              = "3" #ex: leave blank for first env, or non-zero-padded number
  }

  hostname            = "us01vlfmgora01" 
  alias               = "${local.lob}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_customer}-oradb01"
  bt_infra_network    = "ny2-autolab-app-ahv"
  bt_infra_cluster    = "ny2-aza-ntnx-13"
  foreman_hostgroup    = "BT Base Server"
}


module "gt_oracle_db_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.hostname
  os_version           = "rhel8"
  alias                = local.alias
  datacenter           = local.datacenter
  bt_infra_network     = local.bt_infra_network
  bt_infra_cluster     = local.bt_infra_cluster
  lob                  = "FMCLOUD"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = local.db_foreman_hostgroup
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "65536"
  additional_disks     = {
    1 = "300"
  }
}



output "gt_oracle_db_1" {
  value = {
    "fqdn"  = "${module.app_server_1.fqdn}",
    "alias" = "${module.app_server_1.alias}",
    "ip"    = "${module.app_server_1.ip}",
  }
}

