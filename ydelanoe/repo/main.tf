terraform {
  backend "http" {}
}


locals {
  product       = "fmcloud"
  environment   = "master"
  hostgroup     = "BT FM Cloud Repo Server"
  datacenter    = "ny2"
  image         = "rhel7"
  infra_cluster = "ny2-aze-ntnx-11"
  infra_network = "ny2-autolab-app"
  facts         = {
    "bt_product"        = "fmcloud"
    "bt_tier"           = "dev"
    "bt_loc"            = "ny2"
    "bt_role"           = "repo"
    "bt_env"            = "01"
  }
}

module "scp_repo" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlfmrepo001"
  alias                = "fm-dev-repo"
  bt_infra_cluster     = local.infra_cluster
  bt_infra_network     = local.infra_network
  os_version           = local.image
  foreman_environment  = local.environment
  foreman_hostgroup    = local.hostgroup
  datacenter           = local.datacenter
  external_facts       = local.facts
  cpus                 = "1"
  memory               = "1024"
  lob                  = local.facts.bt_product
}

output "scp_repo" {
  value = {
    "fqdn"  = "${module.scp_repo.fqdn}",
    "alias" = "${module.scp_repo.alias}",
    "ip"    = "${module.scp_repo.ip}",
  }
}
