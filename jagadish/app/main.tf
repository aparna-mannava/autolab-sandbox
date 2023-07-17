terraform {
  backend "s3" {}
}

locals {
  product     = "cfrm"
  environment = "master"
  datacenter  = "ny2"
  facts       = {
  	"bt_active"  = "false"
    "bt_ach_nutanix_mount" = "off"
    "bt_customer" = "usbank"
    "bt_deployment_mode" = "blue"
    "bt_env" = ""
    "bt_groovy_version" = "2.5.8"
    "bt_ic_tag" = "v0007"
    "bt_ic_version" = "6.9"
    "bt_server_number" = "01"
    "bt_infra_cluster" = "ny5-azh-ntnx-26"
    "bt_infra_network" = "ny2-autolab-app-ahv"
    "bt_product" = "cfrm"
    "bt_server_mode" = "ICBE"
    "bt_role" = "backend"
    "bt_tier" = "dev"
    "be_cpus" = "2"
    "foreman_hostgroup" = "BT CFRM SP Server"
    "be01_hostname"= "us01vlapp00404"
    "os_version" = "rhel7"
  }
}

module "backend_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.be01_hostname
  alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode}${local.facts.bt_server_number}-${local.facts.bt_deployment_mode}"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  os_version           = local.facts.os_version
  cpus                 = local.facts.be_cpus
  foreman_environment  = local.environment
  foreman_hostgroup    = local.facts.foreman_hostgroup
  datacenter           = local.datacenter
  lob                  = "CFRM"
  external_facts       = local.facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

output "backend_1" {
  value = {
    "fqdn"  = module.backend_1.fqdn,
    "alias" = module.backend_1.alias,
    "ip"    = module.backend_1.ip,
  }
}