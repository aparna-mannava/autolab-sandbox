terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product" = "cfrmrd"
    }
    vm01facts    = {
      "bt_role" = "nginx"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
     }
} 

module "nginx_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd950"
  alias                = "cfrmrd-autolab-nginx"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_3463_nginx"
  foreman_hostgroup    = "CFRMRD NGINX"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50", // Disk 1
    2 = "100" //Disk 2
  }
} 

output "nginx_1" {
  value = {
    "fqdn"  = "${module.nginx_1.fqdn}",
    "alias" = "${module.nginx_1.alias}",
    "ip"    = "${module.nginx_1.ip}",
  }
}    