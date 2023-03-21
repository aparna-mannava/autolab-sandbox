
terraform {
  backend "s3" {}
}

module "rhel7srea1" {
source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
hostname            = "us01vlr7srea1"
bt_infra_cluster    = "ny5-azc-ntnx-16"
bt_infra_network    = "ny2-autolab-app-ahv"
cpus                = 2
lob                 = "CLOUD"
memory              = 4096
os_version          = "rhel7"
foreman_environment = "master"
foreman_hostgroup   = "BT Base Server"
datacenter          = "ny2"
}

output "rhel7srea1" {
value = {
"fqdn"  = module.rhel7srea1.fqdn,
"alias" = module.rhel7srea1.alias,
"ip"    = module.rhel7srea1.ip,
}
}