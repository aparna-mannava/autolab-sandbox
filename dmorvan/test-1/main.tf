terraform {
  backend "s3" {}
}

module "dmts05" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vldmts05"
  alias               = "dmts-ts-05"
  bt_infra_cluster    = "ny5-aza-ntnx-14"
  bt_infra_network    = "ny2-autolab-app-ahv"
  cpus                = 2
  lob                 = "CLOUD"
  memory              = 2048
  os_version          = "rhel9"
  foreman_environment = "nonprod"
  foreman_hostgroup   = "BT Base Server"
  datacenter          = "ny2"
}

output "dmts05" {
  value = {
    "fqdn"  = module.dmts05.fqdn,
    "alias" = module.dmts05.alias,
    "ip"    = module.dmts05.ip,
  }
}