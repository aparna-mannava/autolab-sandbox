terraform {
  backend "http" {}
}
module "streamset-service" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcaesset01.auto.saas-n.com",
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  bt_infra_environment = "ny2-autolab-app"
  os_version           = "rhel8"
  foreman_environment  = "btiq_cae_streamset_dev"
  foreman_hostgroup    = "BTIQ CAE Streamset"
  datacenter           = "ny2"
  lob                  = "btiq-cae",
  alias                = "btiq-cae-streamset-01" .
  cpus                 = "2"
  memory        	   = "2048"
  additional_disks     = {
    1 = "20"
  }
  external_facts       = {
    "bt_tier" = "dev",
    "bt_product"       = "btiq_cae"
    "bt_env"           = ""
    "bt_role"          = "streamset"

    
  }
}

output "app_server_1" {
  value = {
    "fqdn"  = "${module.app_server_1.fqdn}",
    "alias" = "${module.app_server_1.alias}",
    "ip"    = "${module.app_server_1.ip}",
  }
}

