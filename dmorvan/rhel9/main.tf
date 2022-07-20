terraform {
  backend "s3" {}
}

module "rhel9test" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlrhel901"
  alias                = "dmts-rhel9-01"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = 2
  lob                  = "CLOUD"
  memory               = 2048
  os_version           = "rhel9"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
}

output "rhel9test" {
  value = {
    "fqdn"  = module.rhel9test.fqdn,
    "alias" = module.rhel9test.alias,
    "ip"    = module.rhel9test.ip,
  }
}