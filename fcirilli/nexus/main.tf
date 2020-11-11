#
# Build a concourse orchestration server in the autolab
#
# APPLY
#
terraform {
  backend "s3" {}
}

locals {
  environment    = "feature_FMDO_1928_saas_n_puppet_profile_for_nexus"
  datacenter     = "ny2"
  network      = "ny2-autolab-app-ahv"
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
  bt_infra_network     = local.network
  bt_infra_cluster     = local.cluster
  lob                  = "FMCLOUD"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT FM Cloud Nexus3 Server"
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