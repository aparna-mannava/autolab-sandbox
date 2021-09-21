terraform {
  backend "s3" {}
}

module "tfchocotest" {
  source              = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname            = "us01vwtfchoco1"
  alias               = "ny2-cloud-tfchocotest1"
  bt_infra_cluster    = "ny5-azc-ntnx-16"
  bt_infra_network    = "ny2-autolab-app-ahv"
  cpus                = 2
  lob                 = "CLOUD"
  memory              = 4096
  os_version          = "win2019"
  foreman_environment = "master"
  foreman_hostgroup   = "BT Base Windows Server"
  datacenter          = "ny2"
  external_facts = {
    bt_tier    = "lab"
    bt_product = "inf"
    bt_role    = "chocolatey_server"
  }
}

output "tfchocotest" {
  value = {
    "fqdn"  = module.tfchocotest.fqdn,
    "alias" = module.tfchocotest.alias,
    "ip"    = module.tfchocotest.ip,
  }
}
