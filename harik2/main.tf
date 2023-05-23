terraform {
  backend "s3" {}
}
 
locals {
    facts       = {
      bt_customer         = "base01"
      bt_product          = "cfrmcloud"
      bt_lob              = "CFRM"
      bt_tier             = "dev"
      bt_env              = "master"
      bt_role             = "base"
      bt_infra_cluster    = "ny5-aza-ntnx-14"
      bt_infra_network    = "ny2-autolab-app-ahv"
      hostgroup           = "BT CFRM CLOUD Linux base servers"
      environment         = "master"
      hostname            = "ny2vlcfrmbs"
    }
    datacenter = {
      name = "ny2"
      id   = "ny2"
  }
}
 
module "datahub_1" {
  source               = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}01" //ny2vlcfrmbs01
  alias                = "${local.facts.bt_product}-${local.facts.bt_role}-${local.facts.bt_tier}01"//cfrmcloud-base-dev01.saas-n.com
  bt_infra_network     = local.facts.bt_infra_network
  bt_infra_cluster     = local.facts.bt_infra_cluster
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  bt_lob               = local.facts.bt_lob
  cpus                 = 2
  memory               = 4096
  os_version           = "rhel7"
  external_facts       = local.facts
  additional_disks     = {
      1 = "50"
  }
}