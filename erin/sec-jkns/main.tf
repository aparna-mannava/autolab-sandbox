terraform {
  backend "s3" {}
}

module "jenkins" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlsecjeg01"
  bt_infra_cluster     = "ny2-aza-ntnx-05"
  bt_infra_network     = "ny2-autolab-app-ahv"
  lob                  = "INF"
  cpus                 = "4"
  memory               = "8192"
  os_version           = "rhel8"
  foreman_environment  = "feature_CEA_9916_sec_jkns"
  foreman_hostgroup    = "BT Security Jenkins Server"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "200",
  }
}

