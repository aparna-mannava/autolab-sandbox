terraform {
  backend "s3" {}
}

module "dmts01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldmts01"
  alias                = "dmts-poc-01"
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

output "dmts01" {
  value = {
    "fqdn"  = module.dmts01.fqdn,
    "alias" = module.dmts01.alias,
    "ip"    = module.dmts01.ip,
  }
}
