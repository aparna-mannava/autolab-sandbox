terraform {
  backend "http" {}
}

locals {
  product     = "cfrmiso"
  environment = "CFRMSUP_1565__automate_oracledb" #  Change to nonprod after 2020-02-11 Puppet release
  hostname    = "us01vwcf"
  hostgroup   = "CFRM BT ISO IL Management Server"
  facts = {
    "bt_tier" = "autolab"
    "bt_customer" = "saasn-fml-uk"
    "bt_product" = "cfrmiso"
	  "bt_role" = "mgmt"
  }
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }
  cfmn001 = {
    hostname = "${local.hostname}mg01"
    silo     = "autolab"
  }
}


module "cfmn001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfmn001.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.cfel01.silo}-${local.facts.bt_role}-${local.cfel01.hostname}"
  bt_infra_cluster    = "ny2-aza-ntnx-05"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "win2019"
  cpus                = "2"
  memory              = "4096"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "50"
  }
}

# module "cfmn002" {
#   source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
#   hostname            = "${local.cfmn002.hostname}"
#   alias               = "${local.product}-${local.datacenter.id}-${local.cfmn002.silo}-${local.facts.bt_role}-${local.cfmn002.hostname}"
#   bt_infra_cluster    = "ny2-aza-ntnx-05"
#   bt_infra_network    = "ny2-autolab-app-ahv"
#   os_version          = "win2019"
#   cpus                = "4"
#   memory              = "8096"
#   lob                 = "cfrm"
#   external_facts      = "${local.facts}"
#   foreman_environment = "${local.environment}"
#   foreman_hostgroup   = "${local.hostgroup}"
#   datacenter          = "${local.datacenter.name}"
#   additional_disks     = {
#     1 = "50"
#   }
# }

output "cfmn001" {
  value = {
    "fqdn"  = "${module.cfmn001.fqdn}",
    "alias" = "${module.cfmn001.alias}",
    "ip"    = "${module.cfmn001.ip}",
  }
}

# output "cfmn002" {
#   value = {
#     "fqdn"  = "${module.cfmn002.fqdn}",
#     "alias" = "${module.cfmn002.alias}",
#     "ip"    = "${module.cfmn002.ip}",
#   }
}