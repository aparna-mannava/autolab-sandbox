terraform {
  backend "http" {}
}

locals {
  product     = "cfrmiso"
  environment = "feature_CFRMISO_249_GB03_CFRM_MGMT1"     #   
  hostname    = "us01"
  hostgroup   = "CFRM BT ISO IL Bastion Hosts"
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
    hostname = "${local.hostname}vwcfmg01"
    silo     = "autolab"
  }
}


module "cfmn001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.cfmn001.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.cfmn001.silo}-${local.facts.bt_role}-${local.cfmn001.hostname}"
  bt_infra_cluster    = "ny2-aza-ntnx-10"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "win2019"
  cpus                = "2"
  memory              = "4096"
  lob                 = "cfrm"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
      1 = "50"    //
  }
}

output "cfmn001" { 
  value = {
    "fqdn"  = "${module.cfmn001.fqdn}",
    "alias" = "${module.cfmn001.alias}",
    "ip"    = "${module.cfmn001.ip}",
  }
}