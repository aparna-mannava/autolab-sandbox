terraform {
  backend "s3" {}
}
 
locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
    }
    vm01facts    = {
      "bt_tier" = "dev"
      "bt_role" = "nginx"
      "bt_env" = "staging"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
     }
     vm02facts    = {
      "bt_tier" = "ppd" 
      "bt_role" = "nginx"
      "bt_env" = ""
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
     }
     vm03facts    = {
      "bt_tier" = "prod"
      "bt_role" = "nginx"
      "bt_env" = ""
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
     }     
   
} 

module "nginx_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd951"
  alias                = "cfrmrd-autolab-nginx1"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_4829_Fix_Nginx"
  foreman_hostgroup    = "CFRMRD NGINX"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50", // Disk 1
    2 = "100" //Disk 2
  }
} 

module "nginx_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd952"
  alias                = "cfrmrd-autolab-nginx2"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm02facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_4829_Fix_Nginx"
  foreman_hostgroup    = "CFRMRD NGINX"
  datacenter           = "ny2"
  cpus                 = "2"
  memory         	   = "4096"
  additional_disks     = {
    1 = "50", // Disk 1
    2 = "100" //Disk 2
  }
}

module "nginx_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd953"
  alias                = "cfrmrd-autolab-nginx3"
  bt_infra_cluster     = "ny2-azb-ntnx-08"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm03facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_4829_Fix_Nginx"
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

output "nginx_2" {
  value = {
    "fqdn"  = "${module.nginx_2.fqdn}",
    "alias" = "${module.nginx_2.alias}",
    "ip"    = "${module.nginx_2.ip}",
  }
}

output "nginx_3" {
  value = {
    "fqdn"  = "${module.nginx_3.fqdn}",
    "alias" = "${module.nginx_3.alias}",
    "ip"    = "${module.nginx_3.ip}",
  }
}   