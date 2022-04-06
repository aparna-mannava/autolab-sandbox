terraform {
  backend "s3" {}
}

locals {
  lob         = "cfrm"
  product     = "cfrm"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "dev"
    "bt_product" = "cfrm"
    "bt_env"  = "dev"
    "bt_customer" = "datahub"
    "bt_manage_plugins" = "NO"
    "bt_jenkins_version" = "2.207"
    "bt_role" = "jenkins"
  }
}

module "jenkins_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljkns00002"
  alias                = "cfrm-datahub-prod-jkns01"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  firewall_group       = "CFRM_PR_ICBE"
  os_version           = "rhel7"
  cpus                 = "4"
  lob                  = "cfrm"
  memory               = "4096"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT CFRM Jenkins Active Server"
  datacenter           = local.datacenter
  external_facts       = local.facts
  additional_disks     = {
    1 = "300",
    2 = "150"
  }
}

output "jenkins_server_1" {
  value = {
    "fqdn"  = module.jenkins_server_1.fqdn,
    "alias" = module.jenkins_server_1.alias,
    "ip"    = module.jenkins_server_1.ip,
  }
}
