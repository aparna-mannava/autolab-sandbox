terraform {
  backend "http" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
    }
    vm01facts    = {
      "bt_role" = "nginx"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
     }
     ap1facts    = {
      "bt_role" = "app"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_ic_mode" = "FRONTEND"
     }
     ap2facts    = {
      "bt_role" = "app"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_ic_mode" = "FRONTEND"
     }
     ap3facts    = {
      "bt_role" = "app"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_ic_mode" = "BACKEND"
     }
} 

module "nginx_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd950"
  alias                = "cfrmrd-autolab-nginx"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.ap1facts
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

module "app_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd951"
  alias                = "cfrmrd-autolab-frontend1"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.ap2facts
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

module "app_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd952"
  alias                = "cfrmrd-autolab-frontend2"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.ap3facts
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

module "app_3" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd953"
  alias                = "cfrmrd-autolab-backend"
  bt_infra_cluster     = "ny2-aza-ntnx-13"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  external_facts       = local.vm01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMX_3463_nginx"
  foreman_hostgroup    = "CFRMRD NGINX"
  datacenter           = "ny2"
  cpus                 = "4"
  memory         	   = "8192"
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

output "app_1" {
  value = {
    "fqdn"  = "${module.app_1.fqdn}",
    "alias" = "${module.app_1.alias}",
    "ip"    = "${module.app_1.ip}",
  }
}  

output "app_2" {
  value = {
    "fqdn"  = "${module.app_2.fqdn}",
    "alias" = "${module.app_2.alias}",
    "ip"    = "${module.app_2.ip}",
  }
}

output "app_3" {
  value = {
    "fqdn"  = "${module.app_3.fqdn}",
    "alias" = "${module.app_3.alias}",
    "ip"    = "${module.app_3.ip}",
  }
}