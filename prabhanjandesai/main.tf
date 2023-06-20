module "us01vwnxste01" {
  source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vwnxste09"
  bt_infra_cluster    = "ny2-azb-ntnx-08"
  bt_infra_network    = "ny2-autolab-app-ahv"
  cpus                = 4
  lob                 = "CLOUD"
  memory              = 8192
  os_version          = "win2019"
  foreman_environment = "master"
  foreman_hostgroup   = "BT Base Server"
  foreman_hostgroup   = "BT Base Windows Server"
  datacenter = "ny2"
}

output "us01vwnxste01" {
  value = {
    "fqdn" = module.us01vwnxste01.fqdn,
    "alias" = module.us01vwnxste01.alias,
    "ip" = module.us01vwnxste01.ip,
  }
}