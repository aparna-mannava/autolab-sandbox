terraform {
  backend "s3" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
      "bt_role"     = "standalone"
    }
    staging_jenkins_facts    = {
      "bt_env"      = "devops"
      "bt_role"     = local.facts.bt_role
      "bt_customer" = local.facts.bt_customer
      "bt_product"  = local.facts.bt_product
      "bt_tier"     = local.facts.bt_tier
     
     }    
}
 
module "staging_jenkins" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmart"
  alias                = "cfrmws-art"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-azd-ntnx-27"
  cpus                 = "8"
  memory               = "24000"
  os_version           = "rhel8"
  external_facts       = local.staging_jenkins_facts
  foreman_environment  = "feature_CFRMRD_40239"
  foreman_hostgroup    = "BT CFRMRD Artemis"
  lob                  = "CFRM"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
	2 = "200"
  }
}

output "staging_jenkins" {
  value = {
    "fqdn"  = module.staging_jenkins.fqdn,
    "alias" = module.staging_jenkins.alias,
    "ip"    = module.staging_jenkins.ip,
  }
} 