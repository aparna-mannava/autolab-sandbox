terraform {
  backend "s3" {}
}
module "app_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrm445"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app-ahv"
  cpus                 = "2"
  os_version           = "rhel7"
  memory               = "8192"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  lob                  = "CLOUD" # Replace this with your own line of business
  
  external_facts       = {
    "bt_tier" = "dev"
  }
}

output "app_server_1" {
  value = {
    "fqdn"  = "${module.app_server_1.fqdn}",
    "alias" = "${module.app_server_1.alias}",
    "ip"    = "${module.app_server_1.ip}",
  }
}