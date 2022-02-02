terraform {
  backend "s3" {}
}
locals {
  product     = "cfrm"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
  	"bt_ach_nutanix_mount" = "on"
  	"bt_customer"          = "dgbpci"
  	"bt_deployment_mode"   = "blue"
  	"bt_env"               = ""
  	"bt_groovy_version"    = "2.5.8"
  	"bt_ic_tag"            = "v0002"
  	"bt_ic_version"        = "6.2.0.SP1"
bt_infra_network     ="ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  	"bt_product"           = "cfrm"
  	"bt_server_mode_fe"    = "icfe"
    "bt_server_mode_be"    = "icbe"
  	"bt_tier"              = "prod"
  	"fe_cpus"              = "4"
    "be_cpus"              = "6"
    "foreman_hostgroup"    = "BT CFRM SP Server"
    "fe01_hostname"        = "us01vljay07001"
    "be01_hostname"        = "us01vljay07002"
    "memory"               = "30000"
    "os_version"           = "rhel7"
  }
  fe1facts    = {
    "bt_customer" = local.facts.bt_customer
    "bt_product" = local.facts.bt_product
    "bt_tier" = local.facts.bt_tier
    "bt_deployment_mode" = local.facts.bt_deployment_mode
    "bt_env" = local.facts.bt_env
    "bt_server_mode" = local.facts.bt_server_mode_fe
    "bt_role" = "frontend"
    "bt_server_number" = "01"
    "bt_ic_version"        = local.facts.bt_ic_version
    "bt_ic_tag"            = local.facts.bt_ic_tag
    "bt_groovy_version"    = local.facts.bt_groovy_version
    "bt_ach_nutanix_mount" = local.facts.bt_ach_nutanix_mount
    "bt_alias"             = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode_fe}01-${local.facts.bt_deployment_mode}"
  }
  
  be1facts    = {
    "bt_customer" = local.facts.bt_customer
    "bt_product" = local.facts.bt_product
    "bt_tier" = local.facts.bt_tier
    "bt_deployment_mode" = local.facts.bt_deployment_mode
    "bt_env" = local.facts.bt_env
    "bt_server_mode" = local.facts.bt_server_mode_be
    "bt_role" = "backend"
    "bt_server_number" = "01"
    "bt_ic_version" = local.facts.bt_ic_version
    "bt_ic_tag" = local.facts.bt_ic_tag
    "bt_groovy_version" = local.facts.bt_groovy_version
    "bt_ach_nutanix_mount" = local.facts.bt_ach_nutanix_mount
    "bt_alias" = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode_be}01-${local.facts.bt_deployment_mode}"
  }
  

}

module "frontend_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.fe01_hostname
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.fe1facts.bt_server_mode}${local.fe1facts.bt_server_number}-${local.facts.bt_deployment_mode}"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  os_version           = local.facts.os_version
  lob                  = "CLOUD"
  cpus                 = local.facts.fe_cpus
  memory               = local.facts.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.facts.foreman_hostgroup
  datacenter           = local.datacenter
  external_facts       = local.fe1facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

module "backend_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.be01_hostname
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.be1facts.bt_server_mode}${local.be1facts.bt_server_number}-${local.facts.bt_deployment_mode}"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  lob                  = "CLOUD"
  os_version           = local.facts.os_version
  cpus                 = local.facts.fe_cpus
  memory               = local.facts.memory
  foreman_environment  = local.environment
  foreman_hostgroup    = local.facts.foreman_hostgroup
  datacenter           = local.datacenter
  external_facts       = local.be1facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

output "frontend_1" {
  value = {
    "fqdn"  = module.frontend_1.fqdn,
    "alias" = module.frontend_1.alias,
    "ip"    = module.frontend_1.ip,
  }
}


output "backend_1" {
  value = {
    "fqdn"  = module.backend_1.fqdn,
    "alias" = module.backend_1.alias,
    "ip"    = module.backend_1.ip,
  }
}
