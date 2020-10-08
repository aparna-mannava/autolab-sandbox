terraform {
  backend "http" {}
}

locals {
  product     = "cfrmrd"
  environment = "master" # Change to nonprod after 2020-02-11 Puppet release
  hostname    = "gb03vlcfdb"
  hostgroup   = "BT FML CFRM Oracle DB"
  facts = {
    "bt_tier" = "dev"
    "bt_env"  = "4"
    "bt_customer" = "cfrmrd"
    "bt_product" = "cfrmrd"
	  "bt_role" = "oradb"
  }
  datacenter = {
    name = "colt"
    id   = "gb03"
  }
  cfdb001 = {
    hostname = "${local.hostname}001"
    silo     = "dev"
  }
}

module "cfdb001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfdb001.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.cfdb001.silo}-${local.facts.bt_role}01"
  bt_infra_cluster    = "gb03-azc-ntnx-03"
  bt_infra_network    = "gb03-saas-n-dev-2"
  os_version          = "rhel7"
  cpus                = "4"
  memory              = "16192"
  lob                 = "cfrm"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "250",
	  2 = "250",
	  3 = "250",
	  4 = "250"
  }
}

output "cfdb001" {
  value = {
    "fqdn"  = "${module.cfdb001.fqdn}",
    "alias" = "${module.cfdb001.alias}",
    "ip"    = "${module.cfdb001.ip}",
  }
}