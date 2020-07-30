terraform {
  backend "http" {}
}

locals {
  product     = "inf"
  environment = "nonprod"
  datacenter  = "ny2"
  facts       = {
    "bt_tier" = "ppd"
    "bt_env"  = "1"
  }
}

module "dba_jenkins_server_1" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljknssajk"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-db"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = local.environment
  foreman_hostgroup    = "BT Database Jenkins Server"
  datacenter           = local.datacenter
  lob                  = "CLOUD"
  external_facts       = local.facts
  additional_disks     = {
    1 = "20"
  }
}

output "dba_jenkins_server_1" {
  value = {
    "fqdn"  = "${module.dba_jenkins_server_1.fqdn}",
    "ip"    = "${module.dba_jenkins_server_1.ip}",
  }
}
