terraform {
  backend "s3" {}
}

locals {
    facts       = {
      bt_customer      = ""
      bt_product       = "cfrmcloud"
      bt_lob           = "cfrm"
      bt_tier          = "autolab"
      bt_env           = "01"
      bt_role          = "mgmt"
      bt_infra_cluster = "ny5-azc-ntnx-16"
      bt_infra_network = "ny2-autolab-app-ahv"
      //firewall_group   = "CFRMRD_PR_BE"
      hostgroup        = "BT CFRM CLOUD NFS Servers"
      environment      = "feature_CFRMCLOUD_1292_node_exporter_role_app_cfrm" //
      hostname         = "us01vlcfmg"
    }
    datacenter = {
        name = "ny2"
        id   = "ny2"
  }
    mgmt_nfs_01    = {
      "bt_customer" = local.facts.bt_customer
      "bt_product" = local.facts.bt_product
      "bt_tier" = local.facts.bt_tier
      "bt_env" = local.facts.bt_env
      "bt_role" = local.facts.bt_role
     }
}

module "nfslab_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "${local.facts.hostname}02" //    us01vlcfmg02.auto.saas-n.com
  alias                = "${local.facts.bt_product}-${local.datacenter.id}-nfs01"
  bt_infra_cluster     = local.facts.bt_infra_cluster
  bt_infra_network     = local.facts.bt_infra_network
  //firewall_group       = local.facts.firewall_group
  lob                  = local.facts.bt_lob
  foreman_environment  = local.facts.environment
  foreman_hostgroup    = local.facts.hostgroup
  datacenter           = local.datacenter.name
  external_facts       = local.mgmt_nfs_01
  os_version           = "rhel7"
  cpus                 = "8"
  memory         	     = "32768"
  additional_disks     = {
    1 = "170"
  }
}

output "nfslab_1" {
  value = {
    "fqdn"  = module.nfslab_1.fqdn,
    "alias" = module.nfslab_1.alias,
    "ip"    = module.nfslab_1.ip,
  }
}