terraform {
  backend "s3" {}
}
# Reprovision
locals {
  lob        = "CFRM"
  product     = "cfrm"
  environment = "feature_CUT1_15595_fix_jenkins_puppet_profile"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "sbx"
    "bt_product" = "cfrm"
    "bt_env"  = ""
    "bt_manage_plugins" = "NO"
    "bt_jenkins_version" = "2.323"
    "bt_role" = "jenkins"
  }
}

module "jenkins_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljkns1000"
  alias                = "cfrm-autolab-prod-jkns01"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  lob                   = "CFRM"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT CFRM Jenkins Active Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "200",
    2 = "50",
    3 = "200"
  }
}

output "jenkins_server_1" {
  value = {
    "fqdn"  = module.jenkins_server_1.fqdn,
    "alias" = module.jenkins_server_1.alias,
    "ip"    = module.jenkins_server_1.ip,
  }
}