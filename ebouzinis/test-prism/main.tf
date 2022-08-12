
terraform {
  backend "s3" {}
}

module "testprism" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vltest0001"
  alias                = "test-python-01"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = 2
  lob                  = "CLOUD"
  memory               = 2048
  os_version           = "rhel8"
  foreman_environment  = "nonprod"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
}

output "rhel8dm" {
  value = {
    "fqdn"  = module.testprism.fqdn,
    "alias" = module.testprism.alias,
    "ip"    = module.testprism.ip,
  }
}

