terraform {
  backend "s3" {}
}

module "us01vwnxste02" {
source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
hostname            = "us01vwnxste02"
bt_infra_cluster    = "ny2-azb-ntnx-08"
bt_infra_network    = "ny2-autolab-app-ahv"
cpus                = 4
lob                 = "CLOUD"
memory              = 8192
os_version          = "win2022"
foreman_environment = "master"
foreman_hostgroup   = "BT Base Server"
datacenter          = "ny2"
}

output "us01vwnxste02" {
value = {
"fqdn"  = module.us01vwnxste02.fqdn,
"alias" = module.us01vwnxste02.alias,
"ip"    = module.us01vwnxste02.ip,
}
}