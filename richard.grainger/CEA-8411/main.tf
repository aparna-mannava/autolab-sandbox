terraform {
  backend "s3" {}
}

module "pstest01" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vwpstest01"
  datacenter           = "ny2"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  bt_infra_network     = "ny2-autolab-svc"
  os_version           = "win2019"
  cpus                 = "2"
  memory               = "4096"
  lob                  = "CEA"
  foreman_hostgroup    = "BT Base Windows Server"
  foreman_environment  = "bugfix_CEA_8411_update_powershell_module"
  external_facts       = {
    "bt_role"    = "inf"
    "bt_product" = "cloud"
    "bt_tier"    = "pr"
    "bt_env"     = "1"
  }
}

module "pstest02" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlpstest02"
  datacenter           = "ny2"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  bt_infra_network     = "ny2-autolab-svc"
  os_version           = "rhel7"
  cpus                 = "2"
  memory               = "4096"
  lob                  = "CEA"
  foreman_hostgroup    = "BT Base Server"
  foreman_environment  = "bugfix_CEA_8411_update_powershell_module"
  external_facts       = {
    "bt_role"    = "inf"
    "bt_product" = "cloud"
    "bt_tier"    = "pr"
    "bt_env"     = "1"
  }
}

output "pstest01" {
  value = {
    "fqdn"  = "${module.pstest01.fqdn}",
    "ip"    = "${module.pstest01.ip}",
  }
}

output "pstest02" {
  value = {
    "fqdn"  = "${module.pstest02.fqdn}",
    "ip"    = "${module.pstest02.ip}",
  }
}
