terraform {
backend "http" {}
}
module "postgres_serverHSP" {
source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
hostname = "us01vlpghsp01"
alias = "lx-pg-demo-db01"
bt_infra_cluster     = "ny2-aza-vmw-autolab"
bt_infra_network     = "ny2-autolab-app"
cpus = 2
memory = 8096
os_version = "rhel7"
foreman_environment = "nonprod"
foreman_hostgroup = "BT Postgresql DB Server"
datacenter = "ny2"
lob        = "CLOUD"
additional_disks = {
1 = "200",
2 = "320",
3 = "320",
}
}

output "postgres_serverHSP" {
value = {
"fqdn" = "${module.postgres_server1.fqdn}",
"alias" = "${module.postgres_server1.alias}",
"ip" = "${module.postgres_server1.ip}",
}
}
