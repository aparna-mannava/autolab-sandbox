#
# Build a concourse orchestration server in the autolab
#
terraform {
  backend "s3" {}
}

locals {
  environment    = "feature_FMDO_1927_saas_n_puppet_profile_for_jenkins"
  datacenter     = "ny2"
  datastore      = "ny2-dgb-development"
  cluster        = "ny2-aza-ntnx-13"
  facts          = {
    "bt_tier"          = "dev"
    "bt_role"          = "nexus3"
  }
}

module "nexus" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmnxs01"
  alias                = "fmcloud-nexus-e2e"
  bt_infra_network     = local.datastore
  bt_infra_cluster     = local.cluster
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "FM Cloud Nexus3 Server"
  external_facts       = local.facts
  datacenter           = local.datacenter
  additional_disks     = {
    1 = "300",
  }
}

output "nexus" {
  value = {
    "fqdn"  = "${module.nexus.fqdn}",
    "alias" = "${module.nexus.alias}",
    "ip"    = "${module.nexus.ip}",
  }
}