
terraform {
  backend "s3" {}
}

module "rhel9srea1" {
source              = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
hostname            = "us01vlr9srea2"
bt_infra_cluster    = "ny5-azf-ntnx-24"
bt_infra_network    = "ny2-autolab-app-ahv"
cpus                = 2
lob                 = "CLOUD"
memory              = 2048
os_version          = "rhel9"
foreman_environment = "master"
foreman_hostgroup   = "BT Base Server"
datacenter          = "ny2"
}

output "rhel9srea1" {
value = {
"fqdn"  = module.rhel9srea1.fqdn,
"alias" = module.rhel9srea1.alias,
"ip"    = module.rhel9srea1.ip,
}
}