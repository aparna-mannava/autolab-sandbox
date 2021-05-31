terraform {
  backend "s3" {}
}
locals {
  product     = "cfrmcloud"
  environment = "feature_CFRMCLOUD_824_cfrm_cloud_user_key"    #  
  hostname    = "us01"
  hostgroup   = "BT CFRM CLOUD MGMT Base test"
  facts = {
    "bt_tier" = "autolab"
    "bt_customer" = ""
    "bt_product" = "cfrmcloud"
	  "bt_role" = "mgmt"
  }
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }
  cfmn001 = {
    hostname = "${local.hostname}vlcfmg12"
    silo     = "autolab"
  }

}


module "cfmn001" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = local.cfmn001.hostname
  alias               = "${local.product}-${local.datacenter.id}-${local.cfmn001.silo}-${local.facts.bt_role}-${local.cfmn001.hostname}"
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-db-ahv"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "4096"
  lob                 = "cfrm"
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter.name
  additional_disks     = {
      1 = "150"    //
  }
}


output "cfmn001" { 
  value = {
    "fqdn"  = "${module.cfmn001.fqdn}",
    "alias" = "${module.cfmn001.alias}",
    "ip"    = "${module.cfmn001.ip}",
  }

}