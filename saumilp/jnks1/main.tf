terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_lob           = "CLOUD"
      bt_tier          = "pr"
      bt_env           = "1"
      bt_jenkins_mode  = "agent"
      hostgroup        = "BT Database Jenkins Server"
      environment      = "feature_CLOUD_102078"
      datacenter       = "ny2"
    }
}

module "jnks" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljknstst78"
  alias                = "cloud-dba-pr-agent-tst78"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.facts.datacenter}"
  external_facts       = local.facts
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "8192"
  additional_disks     = {
      1 = "200"
  }
}


output "jnks" {
  value = {
    "fqdn"  = module.jnks.fqdn,
    "ip"    = module.jnks.ip,
  }
}
