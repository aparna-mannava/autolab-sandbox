terraform {
  backend "s3" {}
}

locals {
  product     = "cfrm"
  environment = "feature_CLOUD_404"
  datacenter  = "ny2"
  facts       = {
  	bt_lob      = "CLOUD"
    bt_tier     = "dev"
    bt_env      = ""
    domain      = "saas-n.com" 	
    bt_customer = "dgb"
    bt_product  = "cfrm"
    bt_tier     = "ppd"
    bt_role     = "backend4"
    bt_dns_role = "icbe"
    bt_alias    = "ny5-aza-ntnx-404"    
  }
}

module "backend_4" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlapp000404"
  alias                = "ny5-aza-ntnx-404"
  bt_infra_environment = "ny2-autolab-apps"
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT CFRM Backend4 Server"
  firewall_group       = "CFRM_PPD_ICBE"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

output "backend_4" {
  value = {
    "fqdn"  = module.backend_4.fqdn,
    "alias" = module.backend_4.alias,
    "ip"    = module.backend_4.ip,
  }
}