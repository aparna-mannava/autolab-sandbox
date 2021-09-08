terraform {
  backend "s3" {}
}

module "ptch01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwtchpoc01"
  alias                = "ptch-poc-02"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = 2
  lob                  = "CLOUD"
  memory               = 2048
  os_version           = "win2019"
  foreman_environment  = "nonprod"
  foreman_hostgroup    = "BT Windows Base Server"
  datacenter           = "ny2"
}

output "ptch01" {
  value = {
    "fqdn"  = module.ptch01.fqdn,
    "alias" = module.ptch01.alias,
    "ip"    = module.ptch01.ip,
  }
}
