terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
      "bt_env"      = "staging"
    }
    staging_nginx_facts    = {
      "bt_role" = "nginx"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
     }
}
 
module "staging_nginx" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd222"
  alias                = "cfrmx-staging-ic222"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  cpus                 = "1"
  memory               = "2048"
  os_version           = "rhel7"
  external_facts       = local.staging_nginx_facts
  foreman_environment  = "feature_CFRMX_4557_NGINX_failures"
  foreman_hostgroup    = "CFRMRD NGINX"
  lob                  = "CFRM"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
	2 = "100"
  }
}

output "staging_nginx" {
  value = {
    "fqdn"  = "${module.staging_nginx.fqdn}",
    "alias" = "${module.staging_nginx.alias}",
    "ip"    = "${module.staging_nginx.ip}"
  }
} 