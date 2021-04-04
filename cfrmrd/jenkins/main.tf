terraform {
  backend "s3" {}
}
       
locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
      "bt_env"      = "staging"
    }
    staging_jenkins_facts    = {
      "bt_role" = "jenkins"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
     }
}
   
module "staging_jenkins" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd223"
  alias                = "cfrmx-jenkins"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  cpus                 = "2"
  memory               = "1024"
  os_version           = "rhel7"
  external_facts       = local.staging_jenkins_facts
  foreman_environment  = "feature_CFRMX_5553_Jenkins"
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
    "fqdn"  = "${module.staging_jenkins.fqdn}",
    "alias" = "${module.staging_jenkins.alias}",
    "ip"    = "${module.staging_jenkins.ip}"
  }
} 