terraform {
  backend "s3" {}
}

locals {
  lob           = "FMCLOUD"
  product       = "fmcloud"
  environment   = "dev"
  hostgroup     = "BT FMCLOUD FMJenkins"
  datacenter    = "ny2"
  image         = "rhel7"
  infra_cluster = "ny2-aza-ntnx-05"
  infra_network = "ny2-autolab-app-ahv"
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
	  "bt_role"           = "fmjenkins"
    "bt_env"            = "02"
  }
}

module "fmcloud_jnk" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmjnk1"
  alias                = "fm-jnk01"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = "feature_FMDO_3243"
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "2"
  memory               = "8192"
  additional_disks     = {
    1 = "100"
  }
}

output "fmcloud_jnk" {
  value = {
    "fqdn"  = "${module.fmcloud_jnk.fqdn}",
    "alias" = "${module.fmcloud_jnk.alias}",
    "ip"    = "${module.fmcloud_jnk.ip}",
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
