terraform {
  backend "http" {}
}

locals {
  product     = "cfrmiso"
  environment = "CFRMSUP_2164_CFRM_Linux_Mgmt"       #     
  hostname    = "us01vlcf"
  hostgroup   = "CFRM BT ISO IL Elastic Servers"
  facts = {
    "bt_tier" = "autolab"
    "bt_customer" = "saasn-fml-uk"
    "bt_product" = "cfrmiso"
	  "bt_role" = "elastic"
    "bt_artemis_version" = "2.11.0"
    "bt_es_version" = "7.8.0"
    "bt_apacheds_version" = "2.0.0_M24"
  }
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }
  cfel01 = {
    hostname = "${local.hostname}el01"
    silo     = "autolab"
  }
}

module "cfel01" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfel01.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.cfel01.silo}-${local.facts.bt_role}-${local.cfel01.hostname}"
  bt_infra_cluster    = "ny2-aza-ntnx-05"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "4"
  memory              = "12288"
  lob                 = "cfrm"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "100",  // disk 1
  }
}

output "cfel01" {
  value = {
    "fqdn"  = "${module.cfel01.fqdn}",
    "alias" = "${module.cfel01.alias}",
    "ip"    = "${module.cfel01.ip}",
  }
}