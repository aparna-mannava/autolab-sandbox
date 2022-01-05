terraform {
  backend "s3" {}
}

locals {
  lob         = "CEA"
  cluster     = "ny2-aza-ntnx-13"
  network     = "ny2-autolab-svc"
  dc          = "ny2"
  facts       = {
    "bt_product" = "${lower(local.lob)}"
  }
}

module "hrbr_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlhrbr99"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  cpus                 = "4"
  memory               = "8192"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "feature_CEA_11776"
  foreman_hostgroup    = "BT CLOUD Harbor Server"
  datacenter           = local.dc
  additional_disks     = {
    1 = "500",
    2 = "500",
    3 = "500",
    4 = "500",
    5 = "500"
  }
}

module "hrbrlb_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlhrbrlb99"
  alias                = "harbor-ny2lab99"
  bt_infra_cluster     = local.cluster
  bt_infra_network     = local.network
  lob                  = local.lob
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "feature_CEA_11776"
  foreman_hostgroup    = "BT CLOUD Harbor LB Server"
  datacenter           = local.dc
  additional_disks     = {
    1 = "100"
  }
}

output "hrbr_server_1" {
  value = {
    "fqdn"  = "${module.hrbr_server_1.fqdn}",
    "alias" = "${module.hrbr_server_1.alias}",
    "ip"    = "${module.hrbr_server_1.ip}",
  }
}

output "hrbrlb_server_1" {
  value = {
    "fqdn"  = "${module.hrbrlb_server_1.fqdn}",
    "alias" = "${module.hrbrlb_server_1.alias}",
    "ip"    = "${module.hrbrlb_server_1.ip}",
  }
}
