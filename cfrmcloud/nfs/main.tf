terraform {
  backend "s3" {}
}

locals {
  product     = "cfrmcloud"
  environment = "feature_CFRMCLOUD_1292_node_exporter_role_app_cfrm"    #  
  hostname    = "us01"
  hostgroup   = "CFRM BT CLOUD NFS Server"
  facts = {
    "bt_tier" = "autolab"
    "bt_customer" = ""
    "bt_product" = "cfrmcloud"
	  "bt_role" = "mgmt"
  }
  datacenter = {
    name = "ny2"
    id   = "ny2"
  }

  cfmn002 = {
    hostname = "${local.hostname}vlcfmg02"
    silo     = "autolab"
  }
}

module "cfmn002" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = local.cfmn002.hostname
  alias               = "${local.product}-${local.datacenter.id}-${local.cfmn002.silo}-${local.facts.bt_role}-${local.cfmn002.hostname}"
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  os_version          = "rhel7"
  cpus                = "8"
  memory              = "24960"
  lob                 = "cfrm"
  external_facts      = local.facts
  foreman_environment = local.environment
  foreman_hostgroup   = local.hostgroup
  datacenter          = local.datacenter.name
  additional_disks     = {
      1 = "200"  //   disk 1  PR 1
  }
}

output "cfmn002" {
  value = {
    "fqdn"  = module.cfmn002.fqdn,
    "alias" = module.cfmn002.alias,
    "ip"    = module.cfmn002.ip  
    }
}

}