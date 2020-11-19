terraform {
  backend "http" {}
}

locals {
  product     = "cfrmiso"
  environment = "master" # Change to nonprod after 2020-02-11 Puppet release
  hostname    = "gb03vlcf"
  hostgroup   = "BT FML CFRM Application Servers"
  facts = {
    "bt_tier" = "uat" # ['PPD','SBX','PROD','DR','UAT']
    "bt_customer" = "FML" # ['FML','FMG','FMA'] for now
    "bt_product" = "CFRM"
	  "bt_role" = "app"
    "bt_server_mode" = "STANDALONE" # ['ICFE','ICBE','STANDALONE']
    "bt_deployment_mode" = "NONE" # ['BLUE','GREEN','NONE']
    "bt_cfrm_version" = "6.1_SP1" # 
    
  }
  datacenter = {
    name = "colt"
    id   = "gb03"
  }
  cfae01 = {
    hostname = "${local.hostname}ae002"
    silo     = "dev"
  }
  cfic01 = {
    hostname = "${local.hostname}ic002"
    silo     = "dev"
  }  
}

module "cfae01" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfae01.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.cfae01.silo}-${local.facts.bt_role}-${local.cfae01.hostname}"
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


module "cfic01" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfic01.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.cfic01.silo}-${local.facts.bt_role}-${local.cfic01.hostname}"
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

output "cfic01" {
  value = {
    "fqdn"  = "${module.cfic01.fqdn}",
    "alias" = "${module.cfic01.alias}",
    "ip"    = "${module.cfic01.ip}",
  }
}

output "cfae01" {
  value = {
    "fqdn"  = "${module.cfae01.fqdn}",
    "alias" = "${module.cfae01.alias}",
    "ip"    = "${module.cfae01.ip}",
  }
}