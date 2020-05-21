# Last Build -- 2020-05-20
terraform {
  backend "http" {}
}

module "test_101" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljgtest101"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-app"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CEA"
}

module "test_102" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljgtest102"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CEA"
}

module "test_103" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljgtest103"
  bt_infra_cluster     = "ny2-aza-vmw-autolab"
  bt_infra_network     = "ny2-autolab-svc"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CEA"
}

module "test_104" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljgtest104"
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
    "${module.test_101.fqdn}" = "${module.test_101.ip}",
    "${module.test_102.fqdn}" = "${module.test_102.ip}",
    "${module.test_103.fqdn}" = "${module.test_103.ip}",
    "${module.test_104.fqdn}" = "${module.test_104.ip}"
  }
}
