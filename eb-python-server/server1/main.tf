terraform {
  backend "s3" {}
}

module "eb-python-server" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlebpythdev"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  bt_infra_network     = "ny2-kubernetes-aze-auto"
  cpus                 = 4
  lob                  = "CLOUD"
  memory               = 16000
  os_version           = "rhel8"
  foreman_environment  = "master"
  foreman_hostgroup    = "BT Base Server"
  datacenter           = "ny2"
  external_facts       = {
    "bt_product" = "inf"
    "bt_tier" = "autolab"
  }

  additional_disks     = {
    1 = "500"
  }

}

output "eb-python-server" {
  value = {
    "fqdn"  = module.eb-python-server.fqdn,
    "alias" = module.eb-python-server.alias,
    "ip"    = module.eb-python-server.ip,
  }
}