terraform {
  backend "http" {}
}

module "test_001" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljgtest201"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CEA"
}

module "test_201" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vljgtest201"
  bt_infra_cluster     = "ny2-aze-ntnx-11"
  bt_infra_network     = "ny2-autolab-app-ahv"
  os_version           = "rhel7"
  cpus                 = "4"
  memory               = "4096"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  lob                  = "CEA"
}

output "test_servers" {
  value = {
    "${module.test_201.fqdn}" = "${module.test_201.ip}"
  }
}
