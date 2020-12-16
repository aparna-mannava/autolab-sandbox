#
# Build a concourse orchestration server in the autolab
#
# APPLY

terraform {
  backend "s3" {}
}

locals {
  environment    = "feature_FMDO_2117_vm_provisionning_for_gtsuite_on_saas_n"
  datacenter     = "ny2"
  network      = "ny2-autolab-app-ahv"
  cluster        = "ny2-aza-ntnx-13"

}

module "nexus" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmgora01"
  alias                = "fmg-oracle-01"
  bt_infra_network     = local.network
  bt_infra_cluster     = local.cluster
  lob                  = "DGB"
  os_version           = "rhel8"
  cpus                 = "4"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Base Server"
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