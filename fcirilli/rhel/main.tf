#Del PLAN

terraform {
  backend "s3" {}
}

locals {
  lob           = "fmcloud"
  puppet_env    = "feature_FMDO_2117_vm_provisionning_for_gtsuite_on_saas_n"
  datacenter    = "ny2"
  domain        = "saas-n.com"
  facts         = {
    "bt_product"          = "fmcloud"
    "bt_tier"             = "autolab"
    "bt_role"             = "rhel8"
    "bt_loc"              = "ny2"

  }

  hostname            = "us01vlfmgora01" 
  alias               = "${local.lob}-${local.facts.bt_tier}-${local.facts.bt_role}"
  bt_infra_network    = "ny2-autolab-app-ahv"
  bt_infra_cluster    = "ny2-aza-ntnx-07"
  foreman_hostgroup    = "BT FMG RHEL Base server"
}


module "gt_oracle_db_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.hostname
  os_version           = "rhel8"
  alias                = local.alias
  datacenter           = local.datacenter
  bt_infra_network     = local.bt_infra_network
  bt_infra_cluster     = local.bt_infra_cluster
  lob                  = "fmcloud"
  foreman_environment  = local.puppet_env
  foreman_hostgroup    = local.foreman_hostgroup
  external_facts       = local.facts
  cpus                 = "8"
  memory               = "65536"
  additional_disks     = {
    1 = "300"
  }
}



output "gt_oracle_db_1" {
  value = {
    "fqdn"  = "${module.gt_oracle_db_1.fqdn}",
    "alias" = "${module.gt_oracle_db_1.alias}",
    "ip"    = "${module.gt_oracle_db_1.ip}",
  }
}

