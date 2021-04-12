terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer      = ""
      bt_product       = "cfrmcloud"
      bt_lob           = "cfrm"
      bt_tier          = "dev"
      bt_env           = ""
      bt_role          = "mgmt"
      bt_infra_cluster = "ny2-aze-ntnx-12"
      bt_infra_network = "ny2-autolab-app-ahv"
      hostgroup        = "BT CFRM CLOUD MGMT Base"
      environment      = "feature/CFRMGC-737-cfrm-cloud-devops-can-you-add-this-3-lines-to-the-end-of-etc-profile-by-puppet"
      hostname         = "us01vlcfmgmt01p"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}

module "mglabp_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}" 
  alias                = "${local.facts.bt_product}.${local.facts.bt_tier}.${local.datacenter.id}.pmg1"// cfrmcloud.cfrm.auto.gb00.db01
  bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
  bt_infra_network     = "${local.facts.bt_infra_network}"
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.datacenter.name}"
  external_facts       = local.facts
  os_version           = "rhel7"
  cpus                 = "4"
  memory         	     = "8096"
  additional_disks  = {
    1 = "50"
  }
} 

output "mglabp_1" {
  value = {
    "fqdn"  = "${module.mglabp_1.fqdn}",
    "alias" = "${module.mglabp_1.alias}",
    "ip"    = "${module.mglabp_1.ip}",
  }
}