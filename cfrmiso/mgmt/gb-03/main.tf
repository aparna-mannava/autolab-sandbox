terraform {
  backend "http" {}
}

locals {
  product     = "fml"
  environment = "master" # Change to nonprod after 2020-02-11 Puppet release
  hostname    = "gb03vwcf"
  hostgroup   = "BT FML CFRM Management Server"
  facts = {
    "bt_tier" = "ts-saasn"
    #"bt_customer" = "saasn-fml-uk"
    "bt_product" = "fml"
	  "bt_role" = "cfmn"
  }
  datacenter = {
    name = "colt"
    id   = "gb03"
  }
  cfmn001 = {
    hostname = "${local.hostname}mn001"
    silo     = "dev"
  }
  cfmn002 = {
    hostname = "${local.hostname}mg002"
    silo     = "uat"
  }
}

module "cfmn001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfmn001.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.cfmn001.silo}-${local.facts.bt_role}01"
  bt_infra_cluster    = "gb03-aza-ntnx-01"
  bt_infra_network    = "gb03-saas-n-dev-2"
  os_version          = "win2019"
  cpus                = "1"
  memory              = "4096"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
}

module "cfmn002" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfmn002.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.cfmn002.silo}-${local.facts.bt_role}-${local.cfmn002.hostname}"
  bt_infra_cluster    = "gb03-azc-ntnx-03"
  bt_infra_network    = "gb03-saas-n-dev-2"
  os_version          = "win2019"
  cpus                = "4"
  memory              = "8096"
  lob                 = "cfrm"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "50"
  }
}

output "cfmn001" {
  value = {
    "fqdn"  = "${module.cfmn001.fqdn}",
    "alias" = "${module.cfmn001.alias}",
    "ip"    = "${module.cfmn001.ip}",
  }
}

output "cfmn002" {
  value = {
    "fqdn"  = "${module.cfmn002.fqdn}",
    "alias" = "${module.cfmn002.alias}",
    "ip"    = "${module.cfmn002.ip}",
  }
}