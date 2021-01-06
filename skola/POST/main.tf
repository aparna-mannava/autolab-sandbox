terraform {
backend "http" {}
}
module "postgres_server1" {
source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
hostname = "us01vltfkola05"
alias = "tf-pg-demo-p05"
bt_infra_cluster     = "ny5-aza-ntnx-14"
bt_infra_network     = "ny2-autolab-app-ahv"
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
output "postgres_server1" {
value = {
"fqdn" = "${module.postgres_server1.fqdn}",
"alias" = "${module.postgres_server1.alias}",
"ip" = "${module.postgres_server1.ip}",
}
}
