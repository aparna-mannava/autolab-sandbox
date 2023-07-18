terraform {
  backend "s3" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_env" = "dgbs"
    } 

    os04facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = "app"
    }
}

module "opensearch_4" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrm14"
  alias                = "cfrm-5"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  os_version           = "rhel8"
  external_facts       = local.os04facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_40239"
  foreman_hostgroup    = "CFRMRD App"
  datacenter           = "ny2"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
}

output "opensearch_4" {
  value = {
    "fqdn"  = module.opensearch_4.fqdn,
    "alias" = module.opensearch_4.alias,
    "ip"    = module.opensearch_4.ip,
  }
}






