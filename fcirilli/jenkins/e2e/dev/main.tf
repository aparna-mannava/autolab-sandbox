#
# Build a concourse orchestration server in the autolab
#
terraform {
  backend "s3" {}
}


locals {
  environment    = "feature_FMDO_1927_saas_n_puppet_profile_for_jenkins"
  datacenter     = "ny2"
  network      = "ny2-autolab-app-ahv"
  cluster        = "ny2-aza-ntnx-13"
  facts          = {
    "bt_tier"          = "dev"
    "bt_env"           = "03"
    "bt_product"       = "fmcloud"
  }
}


module "jenkins-master" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmjnkns01"
  alias                = "fmcloud-jenkins-e2e"
  bt_infra_network     = local.network
  bt_infra_cluster     = local.cluster
  lob                  = "FMCLOUD"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT FM Cloud Jenkins E2E"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "200",
    2 = "100",
  }
}

output "jenkins-e2e" {
  value = {
    "fqdn"  = "${module.jenkins-master.fqdn}",
    "alias" = "${module.jenkins-master.alias}",
    "ip"    = "${module.jenkins-master.ip}",
  }
}
