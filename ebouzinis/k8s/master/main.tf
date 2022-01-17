terraform {
  backend "s3" {}
}

module "dmts03" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlk8smast3r"
  alias                = "k8s-poc-master1"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = 16
  lob                  = "CLOUD"
  memory               = 32000
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