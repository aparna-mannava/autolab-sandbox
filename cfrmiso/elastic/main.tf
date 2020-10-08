terraform {
  backend "http" {}
}

locals {
  product     = "cfrmiso"
  environment = "master" # Change to nonprod after 2020-02-11 Puppet release
  hostname    = "gb03vlcfel"
  hostgroup   = "BT FML CFRM ELK Server"
  facts = {
    "bt_tier" = "uat"
    "bt_customer" = "saasn-fml-uk"
    "bt_product" = "cfrmiso"
	  "bt_role" = "elastic"
    #"bt_artemis_version" = "2.11.0"
    #"bt_es_version" = "7.8.0"
  }
  datacenter = {
    name = "colt"
    id   = "gb03"
  }
  cfel002 = {
    hostname = "${local.hostname}002"
    silo     = "dev"
  }
}

module "cfel002" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfel002.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.cfel002.silo}-${local.facts.bt_role}-${local.cfel002.hostname}"
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
    1 = "150"
  }
}

output "cfel002" {
  value = {
    "fqdn"  = "${module.cfel002.fqdn}",
    "alias" = "${module.cfel002.alias}",
    "ip"    = "${module.cfel002.ip}",
  }
}