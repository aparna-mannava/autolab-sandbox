terraform {
  backend "http" {}
}

locals {
  product     = "cfrmiso"
  environment = "feature_CFRMGC-374_c.hoare_saas_p_uat_servers_instantiation"
  hostname    = "gb03vlchc" // NFS Servers
  hostgroup   = "BT CFRM CHC"
  facts = {
    "bt_tier" = "ppd"
    "bt_customer" = "chc"
    "bt_product" = "cfrmiso"
	  "bt_role" = "mgmt"
  }
  datacenter = {
    name = "colt"
    id   = "gb03"
  }
  
  chcnfs001 = {
    hostname = "${local.hostname}mg001"
    silo     = "autolab"
  }

  # cfmn003 = {
  #   hostname = "${local.hostname}mg003"
  #   silo     = "ppd"
  # }
}

module "chcnfs001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.chcnfs001.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.chcnfs001.silo}-${local.facts.bt_role}-${local.chcnfs001.hostname}"
  bt_infra_cluster    = "gb03-azc-ntnx-03"
  bt_infra_network    = "gb03_cfrm_preprod_app"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "4096"
  lob                 = "cfrm"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "50"
  }
}

# module "cfmn003" {
#   source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
#   hostname            = "${local.cfmn003.hostname}"
#   alias               = "${local.product}-${local.datacenter.id}-${local.cfmn003.silo}-${local.facts.bt_role}-${local.cfmn003.hostname}"
#   bt_infra_cluster    = "gb03-azc-ntnx-03"
#   bt_infra_network    = "gb03-saas-n-dev-2"
#   os_version          = "rhel7"
#   cpus                = "2"
#   memory              = "4096"
#   lob                 = "cfrm"
#   external_facts      = "${local.facts}"
#   foreman_environment = "${local.environment}"
#   foreman_hostgroup   = "${local.hostgroup}"
#   datacenter          = "${local.datacenter.name}"
#   additional_disks     = {
#     1 = "50"
#   }
# }

output "chcnfs001" {
  value = {
    "fqdn"  = "${module.chcnfs001.fqdn}",
    "alias" = "${module.chcnfs001.alias}",
    "ip"    = "${module.chcnfs001.ip}",
  }
}

# output "cfmn003" {
#   value = {
#     "fqdn"  = "${module.cfmn003.fqdn}",
#     "alias" = "${module.cfmn003.alias}",
#     "ip"    = "${module.cfmn003.ip}",
#   }
# }