terraform {
  backend "s3" {}
}

module "us01vwnxstest01" {
source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
hostname            = "us01vwnxstest01"
bt_infra_cluster    = "ny5-azc-ntnx-24"
bt_infra_network    = "ny2-autolab-app-ahv"
cpus                = 4
lob                 = "CLOUD"
memory              = 8192
os_version          = "win2019"
foreman_environment = "master"
foreman_hostgroup   = "BT Base Server"
datacenter          = "ny2"
}

output "us01vwnxstest01" {
value = {
"fqdn"  = module.us01vwnxstest01.fqdn,
"alias" = module.us01vwnxstest01.alias,
"ip"    = module.us01vwnxstest01.ip,
}
}