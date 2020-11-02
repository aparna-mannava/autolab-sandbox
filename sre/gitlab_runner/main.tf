#
# Build a windows server in the autolab for SRE to automate the build process for chocolatey packages
#
terraform {
  backend "http" {}
}

module "us01vwglr001" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwglr001"
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
  }
  additional_disks     = {
    1 = "20",
  }
}

output "us01vlcncrs0004" {
  value = {
    "fqdn"  = "${module.us01vlcncrs0004.fqdn}",
    "alias" = "${module.us01vlcncrs0004.alias}",
    "ip"    = "${module.us01vlcncrs0004.ip}",
  }
}
