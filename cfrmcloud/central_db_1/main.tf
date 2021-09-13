terraform {
  backend "s3" {}
}
 
 
locals {
    facts       = {
      bt_customer      = ""
      bt_product       = "cfrmcloud"
      bt_lob           = "CFRM"
      bt_tier          = "autolab" //dev
      bt_env           = "01"
      bt_cfrm_version  = "6.1_SP1" //rebuild
      bt_role          = "oradb"
      bt_infra_cluster = "ny5-azc-ntnx-16" 
      bt_infra_network = "ny2-autolab-app-ahv"
      hostgroup        = "BT CFRM CLOUD Oracle DB Servers"
      environment      = "master" //
      hostname         = "us01vlcfdb"
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
      "bt_cfrm_version" = local.facts.bt_cfrm_version
     }
}
 
module "db_lab_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}lab01" //   us01vlcfdblab01.auto.saas-n.com
  alias                = "${local.facts.bt_product}-${local.facts.bt_tier}-${local.datacenter.id}-oradb01"//cfrmcloud-autolab-ny2-oradb01
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.db01prod
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "12386"
  additional_disks     = {
    1 = "300",
      2 = "300",
      3 = "300",
      4 = "300"
  }
}
 
output "db_lab_1" {
  value = {
    "fqdn"  = module.db_lab_1.fqdn,
    "alias" = module.db_lab_1.alias,
    "ip"    = module.db_lab_1.ip,
  }
}