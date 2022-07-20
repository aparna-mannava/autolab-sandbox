terraform {
  backend "s3" {}
}

module "rhel9testa" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlrhel9a1"
  alias                = "dmts-rhel9-a1"
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

output "rhel9testa" {
  value = {
    "fqdn"  = module.rhel9testa.fqdn,
    "alias" = module.rhel9testa.alias,
    "ip"    = module.rhel9testa.ip,
  }
}