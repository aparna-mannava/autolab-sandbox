terraform {
  backend "http" {}
}

locals {
  product     = "cfrm-cloud-chc-u"
  environment = "feature_CFRMGC_373_c_hoare_uat_saas_p_cfrm"
  hostname    = "gb00vlcons01.u.saas-p.com"
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
  
  gb00vlcons01.u.saas-p.com = {
    hostname = "${local.hostname}mg001"
    silo     = "autolab"
  }
}

module "gb00vlcons01.u.saas-p.com" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "${local.gb00vlcons01.u.saas-p.com.hostname}"
  alias               = "${local.product}-${local.datacenter.id}-${local.gb00vlcons01.u.saas-p.com.silo}-${local.facts.bt_role}-${local.gb00vlcons01.u.saas-p.com.hostname}"
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

output "gb00vlcons01.u.saas-p.com" {
  value = {
    "fqdn"  = "${module.gb00vlcons01.u.saas-p.com.fqdn}",
    "alias" = "${module.gb00vlcons01.u.saas-p.com.alias}",
    "ip"    = "${module.gb00vlcons01.u.saas-p.com.ip}",
  }
}