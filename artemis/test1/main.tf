terraform {
  backend "s3" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
      "bt_role"     = "standalone"
    }
    test_jenkins_facts    = {
      "bt_env"                 = "devops"
      "bt_role"                = local.facts.bt_role
      "bt_customer"            = local.facts.bt_customer
      "bt_product"             = local.facts.bt_product
      "bt_tier"                = local.facts.bt_tier
      "bt_artemis_mode"        = "cluster"
      "bt_artemis_server_mode" = "master"
     
     }
    test_jenkins_slave_facts    = {
      "bt_env"                 = "devops"
      "bt_role"                = local.facts.bt_role
      "bt_customer"            = local.facts.bt_customer
      "bt_product"             = local.facts.bt_product
      "bt_tier"                = local.facts.bt_tier
      "bt_artemis_mode"        = "cluster"
      
     }   
}

module "test_jenkins" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd612"
  alias                = "cfrmrd-art4"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  cpus                 = "4"
  memory               = "8192"
  os_version           = "rhel7"
  external_facts       = local.test_jenkins_facts
  foreman_environment  = "feature_CFRMRD_40239"
  foreman_hostgroup    = "BT CFRMRD Artemis"
  lob                  = "CFRM"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
	2 = "100"
  }
}

module "test_jenkins_slave" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd712"
  alias                = "cfrmrd-art5"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny5-aza-ntnx-14"
  cpus                 = "2"
  memory               = "4096"
  os_version           = "rhel7"
  external_facts       = local.test_jenkins_slave_facts
  foreman_environment  = "feature_CFRMRD_40239"
  foreman_hostgroup    = "BT CFRMRD Artemis"
  lob                  = "CFRM"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
	2 = "100"
  }
}

output "test_jenkins" {
  value = {
    "fqdn"  = module.test_jenkins.fqdn,
    "alias" = module.test_jenkins.alias,
    "ip"    = module.test_jenkins.ip,
  }
}
output "test_jenkins_slave" {
  value = {
    "fqdn"  = module.test_jenkins_slave.fqdn,
    "alias" = module.test_jenkins_slave.alias,
    "ip"    = module.test_jenkins_slave.ip,
  }
}