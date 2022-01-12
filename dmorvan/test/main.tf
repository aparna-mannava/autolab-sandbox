terraform {
  backend "s3" {}
}
# destroy
module "dmts03" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldmts03"
  alias                = "dmts-poc-03"
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

output "dmts03" {
  value = {
    "fqdn"  = module.dmts03.fqdn,
    "alias" = module.dmts03.alias,
    "ip"    = module.dmts03.ip,
  }
}