terraform {
backend "http" {}
}
module "postgres_server1" {
source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
hostname = "us01vltfdemo111"
alias = "tf-pg-demo-db111"
bt_infra_cluster     = "ny2-aze-ntnx-11"
bt_infra_network     = "ny2-autolab-db-ahv"
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