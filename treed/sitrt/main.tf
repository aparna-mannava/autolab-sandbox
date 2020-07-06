terraform {
  backend "http" {}
}

locals {
  facts       = {
    "bt_product" = "btiq"
    "bt_role"    = "sisense"
  }
}

module "sisensepoc_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlsitrt01"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  lob                  = "INF"
  cpus                 = "2"
  memory               = "4096"
  external_facts       = local.facts
  os_version           = "rhel7"
  foreman_environment  = "feature_CLOUD_66005"
  foreman_hostgroup    = "BTIQ Sisense Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "100",
  }
}

output "sisensepoc_server_1" {
  value = {
    "fqdn"  = "${module.sisensepoc_server_1.fqdn}",
    "alias" = "${module.sisensepoc_server_1.alias}",
    "ip"    = "${module.sisensepoc_server_1.ip}",
  }
}
