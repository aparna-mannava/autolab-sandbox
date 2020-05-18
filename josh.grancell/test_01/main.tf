terraform {
  backend "http" {}
}

module "test_001" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljgtest001"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CEA"
}

module "test_002" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljgtest002"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CEA"
}

module "test_003" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljgtest003"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-svc"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CEA"
}

module "test_004" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljgtest004"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-svc"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CEA"
}

output "test_servers" {
  value = {
    "${module.test_001.fqdn}" = "${module.test_001.ip}",
    "${module.test_002.fqdn}" = "${module.test_002.ip}",
    "${module.test_003.fqdn}" = "${module.test_003.ip}",
    "${module.test_004.fqdn}" = "${module.test_004.ip}"
  }
}
