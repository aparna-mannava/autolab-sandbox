terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer      = "fi1111"
      bt_product       = "dgb"
      bt_lob           = "CLOUD"
      bt_tier          = "tst"
      bt_env           = "2"
      bt_role          = "oradb"
      bt_em_agent      = "13.4.0.0"
      bt_infra_cluster = "ny5-azc-ntnx-16"
      bt_infra_network = "ny2-autolab-app-ahv"
      hostgroup        = "BT DGB Oradb Server"
      environment      = "feature_CLOUD_91940"
      hostname         = "us01vldbtst98"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
    db01prod    = {
      "bt_customer"     = local.facts.bt_customer
      "bt_product"      = local.facts.bt_product
      "bt_tier"         = local.facts.bt_tier
      "bt_env"          = local.facts.bt_env
      "bt_role"         = local.facts.bt_role
     }

     db02prod    = {
       "bt_customer"     = local.facts.bt_customer
       "bt_product"      = local.facts.bt_product
       "bt_tier"         = local.facts.bt_tier
       "bt_env"          = local.facts.bt_env
       "bt_role"         = local.facts.bt_role
       "bt_em_agent"     = local.facts.bt_em_agent
      }
}

module "dblab_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldbtst98"
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-oralb98"
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.db01prod
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  additional_disks     = {
    1 = "200",
	  2 = "200",
	  3 = "200"
  }
}

module "dblab_2" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vldbtst99"
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-oralb99"
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = "BT DGB Oradb Secondary Server"
  datacenter           = local.datacenter.name
  external_facts       = local.db02prod
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  additional_disks     = {
    1 = "200",
	  2 = "200",
	  3 = "200"
  }
}


output "dblab_1" {
  value = {
    "fqdn"  = module.dblab_1.fqdn,
    "alias" = module.dblab_1.alias,
    "ip"    = module.dblab_1.ip,
  }
}

output "dblab_2" {
  value = {
    "fqdn"  = module.dblab_2.fqdn,
    "alias" = module.dblab_2.alias,
    "ip"    = module.dblab_2.ip,
  }
}
