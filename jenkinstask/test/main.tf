terraform {
  backend "s3" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
      "bt_role"     = "jenkins"
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
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=masterS"
  hostname             = "us01vlcfrmrdprud"
  alias                = "cfrmx-jenkins"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  cpus                 = "2"
  memory               = "8192"
  os_version           = "rhel7"
  external_facts       = local.staging_jenkins_facts
  foreman_environment  = "master"
  foreman_hostgroup    = "CFRMRD Jenkins"
  lob                  = "CFRM"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
	2 = "100"
  }
}

output "staging_jenkins" {
  value = {
    "fqdn"  = module.staging_jenkins.fqdn,
    "alias" = module.staging_jenkins.alias,
    "ip"    = module.staging_jenkins.ip,
  }
} 
