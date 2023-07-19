terraform {
  backend "s3" {}
}

module "us01vwnxsre02" {
source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
hostname            = "us01vwnxsre02"
bt_infra_cluster    = "ny2-azb-ntnx-08"
bt_infra_network    = "ny2-autolab-app-ahv"
cpus                = 4
lob                 = "CLOUD"
memory              = 8192
os_version          = "win2019"
foreman_environment = "feature_SRE_3835_windows_exportert_deployment_test"
foreman_hostgroup   = "BT Base Windows Server"
datacenter          = "ny2"
}

output "us01vwnxsre02" {
value = {
"fqdn"  = module.us01vwnxsre02.fqdn,
"alias" = module.us01vwnxsre02.alias,
"ip"    = module.us01vwnxsre02.ip,
}
}