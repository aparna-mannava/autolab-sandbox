terraform {
  backend "s3" {}
}

locals {
  product       = "fmcloud"
  environment   = "dev"
  hostgroup     = "BT Base Server"
  datacenter    = "ny2"
  facts         = {
    "bt_product"        = "fmcloud"
    /*"bt_short_product"  = "fm"
    "bt_tier"           = "dev"
	  "bt_role"           = "es"
    "bt_env"            = "1"*/
  }
}

module "fmcloud_base" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmbase001"
  alias                = "fm-base01"
  bt_infra_cluster     = "ny2-aza-ntnx-07"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  foreman_environment  = "master"
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "2"
  memory               = "2048"
  additional_disks     = {
    1 = "100"
  }
}

output "fmcloud_base" {
  value = {
    "fqdn"  = "${module.fmcloud_base.fqdn}",
    "alias" = "${module.fmcloud_base.alias}",
    "ip"    = "${module.fmcloud_base.ip}",
  }
}


/*
module "test_data_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmtest002"
  alias                = "fm-test01-d1"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = "master"
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "4"
  memory               = "16384"
  additional_disks     = {
    1 = "150"
  }
}

output "test_data_1" {
  value = {
    "fqdn"  = "${module.test_data_1.fqdn}",
    "alias" = "${module.test_data_1.alias}",
    "ip"    = "${module.test_data_1.ip}"
  }
}*/
