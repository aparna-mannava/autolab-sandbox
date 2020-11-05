#
# Build a windows server in the autolab for SRE to automate the build process for chocolatey packages
#
terraform {
  backend "http" {}
}

module "us01vwsretest001" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwsretest001"
  bt_infra_network     = "ny2-autolab-svc"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  os_version           = "win2016"
  lob                  = "cloud"
  cpus                 = "2"
  memory               = "8192"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Windows Server"
  datacenter           = "ny2"
  external_facts       = {
    "bt_tier"          = "autolab"
    "bt_product"       = "sre"
    "bt_role"          = "gitlab_runner"
    "bt_lob"           = "cloud"
  }
  additional_disks     = {
    1 = "20",
  }
}

output "us01vwsretest001" {
  value = {
    "fqdn"  = "${module.us01vwsretest001.fqdn}",
    "alias" = "${module.us01vwsretest001.alias}",
    "ip"    = "${module.us01vwsretest001.ip}",
  }
}
