terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_env" = ""
      "bt_role" = "nfs"
    }
    app01facts    = {
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
      "bt_role" = "${local.facts.bt_role}"
     }
}

module "nfs_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd50"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.app01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_2872_Add_NFS_Server"
  foreman_hostgroup    = "CFRMRD NFS Server"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
} 

output "nfs_1" {
  value = {
    "fqdn"  = "${module.nfs_1.fqdn}",
    "alias" = "${module.nfs_1.alias}",
    "ip"    = "${module.nfs_1.ip}",
  }
}  