terraform {
  backend "s3" {}
}

locals {
    product     = "cfrm"
    owner       = "cfrmclouddevopsteam@bottomline.com"
    bt_lob      = "CFRM"
    environment = "feature_CFRMCLOUD_3231_metrobank_dev_provision_test_artemis_rr_cluster"
    datacenter  = "ny2"
    facts       = {
        bt_artemis_version = "2.27.1"
        bt_customer        = "metro"
        bt_artemis_ha      = "MasterSlave"
        bt_deployment_mode = "green"
        bt_env             = ""
        bt_infra_cluster   = "ny5-azd-ntnx-27"
        bt_infra_network   = "ny2-autolab-app-ahv"
        bt_product         = "cfrm"
        bt_active          = "false"
        bt_tier            = "dev"
        bt_role            = "artemis_secured_rr"
        bt_server_mode     = "artemisrr"
        cpus               = "2"
        artemis01_hostname = "us01vlmbar01"
        artemis02_hostname = "us01vlmbar02"
        artemis03_hostname = "us01vlmbar03"
        foreman_hostgroup  = "BT CFRM Artemis Secured Server RR"
        memory             = "4096"
        os_version         = "rhel8"
        bt_is_secured      = "true"
        bt_java_arg_min_heap = "512M"
        bt_java_arg_max_heap = "1G"
    }

    artemis01facts    = {
      bt_artemis_ha      = local.facts.bt_artemis_ha
      bt_active          = local.facts.bt_active
      bt_customer        = local.facts.bt_customer
      bt_product         = local.facts.bt_product
      bt_tier            = local.facts.bt_tier
      bt_env             = local.facts.bt_env
      bt_artemis_version = local.facts.bt_artemis_version
      bt_role            = local.facts.bt_role
      bt_server_mode     = local.facts.bt_server_mode
      bt_server_number   = "01"
      bt_deployment_mode = local.facts.bt_deployment_mode
      bt_alias           = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}-${local.facts.bt_server_mode}01-${local.facts.bt_deployment_mode}"
      bt_is_secured      = local.facts.bt_is_secured      
      bt_java_arg_min_heap = local.facts.bt_java_arg_min_heap
      bt_java_arg_max_heap = local.facts.bt_java_arg_max_heap
    }

    artemis02facts    = {
      bt_artemis_ha      = local.facts.bt_artemis_ha
      bt_active          = local.facts.bt_active
      bt_customer        = local.facts.bt_customer
      bt_product         = local.facts.bt_product
      bt_tier            = local.facts.bt_tier
      bt_env             = local.facts.bt_env
      bt_artemis_version = local.facts.bt_artemis_version
      bt_role            = local.facts.bt_role
      bt_server_mode     = local.facts.bt_server_mode
      bt_server_number   = "02"
      bt_deployment_mode = local.facts.bt_deployment_mode
      bt_alias           = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}-${local.facts.bt_server_mode}02-${local.facts.bt_deployment_mode}"
      bt_is_secured      = local.facts.bt_is_secured      
      bt_java_arg_min_heap = local.facts.bt_java_arg_min_heap
      bt_java_arg_max_heap = local.facts.bt_java_arg_max_heap
    }

    artemis03facts    = {
      bt_artemis_ha      = local.facts.bt_artemis_ha
      bt_active          = local.facts.bt_active
      bt_customer        = local.facts.bt_customer
      bt_product         = local.facts.bt_product
      bt_tier            = local.facts.bt_tier
      bt_env             = local.facts.bt_env
      bt_artemis_version = local.facts.bt_artemis_version
      bt_role            = local.facts.bt_role
      bt_server_mode     = local.facts.bt_server_mode
      bt_server_number   = "03"
      bt_deployment_mode = local.facts.bt_deployment_mode
      bt_alias           = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}-${local.facts.bt_server_mode}03-${local.facts.bt_deployment_mode}"
      bt_is_secured      = local.facts.bt_is_secured
      bt_java_arg_min_heap = local.facts.bt_java_arg_min_heap
      bt_java_arg_max_heap = local.facts.bt_java_arg_max_heap      
    }
}

module "artemis_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.artemis01_hostname
  alias                = "${local.artemis01facts.bt_alias}"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  os_version           = local.facts.os_version
  cpus                 = local.facts.cpus
  memory               = local.facts.memory
  owner                = local.owner
  lob                  = local.bt_lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.facts.foreman_hostgroup
  datacenter           = local.datacenter
  external_facts       = local.artemis01facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

module "artemis_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.artemis02_hostname
  alias                = "${local.artemis02facts.bt_alias}"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  os_version           = local.facts.os_version
  cpus                 = local.facts.cpus
  memory               = local.facts.memory
  owner                = local.owner
  lob                  = local.bt_lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.facts.foreman_hostgroup
  datacenter           = local.datacenter
  external_facts       = local.artemis02facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}

module "artemis_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = local.facts.artemis03_hostname
  alias                = "${local.artemis03facts.bt_alias}"
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  os_version           = local.facts.os_version
  cpus                 = local.facts.cpus
  memory               = local.facts.memory
  owner                = local.owner
  lob                  = local.bt_lob
  foreman_environment  = local.environment
  foreman_hostgroup    = local.facts.foreman_hostgroup
  datacenter           = local.datacenter
  external_facts       = local.artemis03facts
  additional_disks     = {
    1 = "50",
    2 = "100"
  }
}


output "artemis_1" {
  value = {
    "fqdn"  = module.artemis_1.fqdn,
    "alias" = module.artemis_1.alias,
    "ip"    = module.artemis_1.ip,
  }
}

output "artemis_2" {
  value = {
    "fqdn"  = module.artemis_2.fqdn,
    "alias" = module.artemis_2.alias,
    "ip"    = module.artemis_2.ip,
  }
}

output "artemis_3" {
  value = {
    "fqdn"  = module.artemis_3.fqdn,
    "alias" = module.artemis_3.alias,
    "ip"    = module.artemis_3.ip,
  }
}