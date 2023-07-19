
terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_lob             = "CLOUD"
      bt_tier            = "pr"
      bt_env             = "1"
      bt_jenkins_version = "2.387.3-1.1"
      hostgroup          = "BT Database Jenkins Server"
      environment        = "feature_CLOUD_121506"
      datacenter         = "ny2"
    }
}

module "jnks" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljkns1889"
  alias                = "cloud-dba-pr-jnks1889"
  bt_infra_cluster     = "ny5-aza-ntnx-19"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "${local.facts.bt_lob}"
  foreman_environment  = "${local.facts.environment}"
  foreman_hostgroup    = "${local.facts.hostgroup}"
  datacenter           = "${local.facts.datacenter}"
  external_facts       = local.facts
  os_version           = "rhel8"
  cpus                 = "2"
  memory               = "4096"
  additional_disks     = {
      1 = "200",
      2 = "100"
  }
}

output "jnks" {
  value = {
    "fqdn"  = module.jnks.fqdn,
    "ip"    = module.jnks.ip,
  }
}
