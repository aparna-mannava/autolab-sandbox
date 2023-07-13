terraform {
  backend "s3" {}
}

locals {
  product     = "cfrm"
  environment = "feature/jagadish-learning-provisioning"
  datacenter  = "ny2"
  facts       = {
  	"bt_active"  = "false"
    "bt_ach_nutanix_mount" = "on"
    "bt_customer" = "dgbcs"
    "bt_deployment_mode" = "blue"
    "bt_env" = ""
    "bt_groovy_version" = "2.5.8"
    "bt_ic_tag" = "v0007"
    "bt_ic_version" = "6.9.1.SP"
    "bt_infra_cluster" = "ny5-azh-ntnx-26"
    "bt_infra_network" = "ny2-dgb-dgb-preprod-app2"
    "bt_product" = "cfrm"
    "bt_server_mode_be" = "icbe"
    "bt_role_be" = "backend"
    "bt_tier" = "dev"
    "be_cpus" = "2"
    "foreman_hostgroup" = "BT CFRM SP Server"
    "be01_hostname"= "us01vlapp00404"
    "memory" = "10000"
    "os_version" = "rhel8"
  }
}

module "backend_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.be01_hostname
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.be1facts.bt_server_mode}${local.be1facts.bt_server_number}-${local.facts.bt_deployment_mode}"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  os_version           = local.facts.os_version
  cpus                 = local.facts.be_cpus
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

be1facts    = {
    "bt_active"   = local.facts.bt_active
    "bt_customer" = local.facts.bt_customer
    "bt_product" = local.facts.bt_product
    "bt_tier" = local.facts.bt_tier
    "bt_deployment_mode" = local.facts.bt_deployment_mode
    "bt_env" = local.facts.bt_env
    "bt_server_mode" = local.facts.bt_server_mode_be
    "bt_role" = local.facts.bt_role_be
    "bt_server_number" = "01"
    "bt_ic_version" = local.facts.bt_ic_version
    "bt_ic_tag" = local.facts.bt_ic_tag
    "bt_groovy_version" = local.facts.bt_groovy_version
    "bt_ach_nutanix_mount" = local.facts.bt_ach_nutanix_mount
    "bt_alias" = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode_be}01-${local.facts.bt_deployment_mode}"
  }

output "backend_1" {
  value = {
    "fqdn"  = module.backend_1.fqdn,
    "alias" = module.backend_1.alias,
    "ip"    = module.backend_1.ip,
  }
}