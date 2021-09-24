terraform {
  backend "s3" {}
}

module "crowdstriketest" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vlcsts1"
  alias               = "ny2-cloud-crowdstriketest1"
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  cpus                = 2
  lob                 = "CLOUD"
  memory              = 4096
  os_version          = "rhel8"
  foreman_environment = "feature_CLOUD_95811_crowdstrike_agent_linux"
  foreman_hostgroup   = "BT Base Server"
  datacenter          = "ny2"
  external_facts = {
    bt_tier    = "lab"
    bt_product = "cloud"
    bt_role    = "crowdstrike_test"
  }
}

output "crowdstriketest" {
  value = {
    "fqdn"  = module.crowdstriketest.fqdn,
    "alias" = module.crowdstriketest.alias,
    "ip"    = module.crowdstriketest.ip,
  }
}
