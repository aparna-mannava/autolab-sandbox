terraform {
  backend "s3" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product" = "cfrmrd"
      "bt_tier" = "dev"
      "bt_env" = "dgbs"
      "bt_role" = "opensearch"
      "bt_opensearch_nodes" = ["us01vlcfrmx1.auto.saas-n.com", "us01vlcfrmx2.auto.saas-n.com","us01vlcfrmx3.auto.saas-n.com"]
    } 
    os01facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = "standalone"
      "bt_opensearch_mode" = "cluster"
      "bt_opensearch_nodes" = local.facts.bt_opensearch_nodes
      "bt_artemis_mode"        = "cluster"
      "bt_artemis_server_mode" = "master"
      "bt_slave_fdqn"          = "us01vlcfrmx2.auto.saas-n.com"
     }
    os02facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = local.facts.bt_role
      "bt_opensearch_nodes" = local.facts.bt_opensearch_nodes
      "bt_artemis_mode"        = "cluster"
      "bt_artemis_server_mode" = "slave"
      "bt_master_fdqn"         = "us01vlcfrmx1.auto.saas-n.com"
     }
    os03facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = local.facts.bt_role
      "bt_opensearch_nodes" = local.facts.bt_opensearch_nodes
    }
    os04facts    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = "app"
    }
}

module "artemis_apacheds_opensearch_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmx1"
  alias                = "cfrmx-1"
  bt_infra_network     = "ny2-autolab-db-ahv"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  os_version           = "rhel8"
  external_facts       = local.os01facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_40239"
  foreman_hostgroup    = "BT CFRMRD Opensearch Artemis cluster ApacheDS"
  datacenter           = "ny2"
  cpus                 = "8"
  memory         	   = "24576"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
} 

module "opensearch_2" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmx2"
  alias                = "cfrmx-2"
  bt_infra_network     = "ny2-autolab-db-ahv"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  os_version           = "rhel8"
  external_facts       = local.os02facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_40239"
  foreman_hostgroup    = "BT CFRMRD Opensearch artemis"
  datacenter           = "ny2"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "100",
    2 = "100"
  } 
}

module "opensearch_3" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmx3"
  alias                = "cfrmx-3"
  bt_infra_network     = "ny2-autolab-db-ahv"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  os_version           = "rhel8"
  external_facts       = local.os03facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_40239"
  foreman_hostgroup    = "BT CFRMRD Opensearch"
  datacenter           = "ny2"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
}

module "opensearch_4" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmx4"
  alias                = "cfrmx-4"
  bt_infra_network     = "ny2-autolab-db-ahv"
  bt_infra_cluster     = "ny5-azc-ntnx-16"
  os_version           = "rhel8"
  external_facts       = local.os04facts
  lob                  = "CFRM"
  foreman_environment  = "feature_CFRMRD_40239"
  foreman_hostgroup    = "CFRMRD App"
  datacenter           = "ny2"
  cpus                 = "4"
  memory         	   = "16192"
  additional_disks     = {
    1 = "100",
    2 = "100"
  }
}

output "artemis_apacheds_opensearch_1" {
  value = {
    "fqdn"  = module.artemis_apacheds_opensearch_1.fqdn,
    "alias" = module.artemis_apacheds_opensearch_1.alias,
    "ip"    = module.artemis_apacheds_opensearch_1.ip,
  }
}

output "opensearch_2" {
  value = {
    "fqdn"  = module.opensearch_2.fqdn,
    "alias" = module.opensearch_2.alias,
    "ip"    = module.opensearch_2.ip,
  }
}

output "opensearch_3" {
  value = {
    "fqdn"  = module.opensearch_3.fqdn,
    "alias" = module.opensearch_3.alias,
    "ip"    = module.opensearch_3.ip,
  }
}

output "opensearch_4" {
  value = {
    "fqdn"  = module.opensearch_4.fqdn,
    "alias" = module.opensearch_4.alias,
    "ip"    = module.opensearch_4.ip,
  }
}


