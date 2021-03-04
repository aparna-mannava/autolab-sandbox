terraform {
  backend "http" {}
}

locals {
  #product     = "cfrm-cloud-chc-u"
  hostname    = "us01vlcons01"
  environment = "feature_CFRMGC_373_c_hoare_uat_saas_p_cfrm"
  silo     = "autolab"
  hostgroup   = "BT CFRM C.Hoare NFS Server"
    facts = {
    "bt_tier" = "autolab"
    "bt_customer" = "chc"
    "bt_product" = "cfrmcloud"
	  "bt_role" = "mgmt"
  }
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }
 }

module "chcnfs01" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.hostname}01"
  alias               = "cfrm-cloud-chc-u-gb00-nfs01"
  bt_infra_cluster    = "ny2-aza-ntnx-05"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "2"
  memory              = "4096"
  lob                 = "cfrm"
  external_facts      = "${local.facts}"
  foreman_environment = "${local.environment}"
  foreman_hostgroup   = "${local.hostgroup}"
  datacenter          = "${local.datacenter.name}"
  additional_disks     = {
    1 = "100"
  }
}

output "chcnfs01" {
  value = {
    "fqdn"  = "${module.chcnfs01.fqdn}",
    "alias" = "${module.chcnfs01.alias}",
    "ip"    = "${module.chcnfs01.ip}",
  }
}