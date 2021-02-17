terraform {
  backend "http" {}
}


locals {
  lob = "sre"
  environment = "master"
  datacenter  = "ny2"
  cluster     = "ny2-azb-ntnx-08"
  network     = "ny2-autolab-svc"
  facts = {
    bt_tier = "autolab"
    bt_product = "inf"
    bt_role = "consul"
    bt_lob = "SRE"
  }
}


module "autolab-consul-3" {
  source = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname = "us01vlcnsl00032"
  bt_infra_cluster = local.cluster
  bt_infra_network = local.network
  os_version = "rhel7"
  cpus = "2"
  memory = "2048"
  lob = local.lob
  foreman_environment = local.environment
  foreman_hostgroup = "BT INF Consul Server"
  datacenter = local.datacenter
  external_facts = local.facts
}

output "autolab-consul-3" {
  value = {
    "fqdn"  = "${module.autolab-consul-3.fqdn}",
    "ip"    = "${module.autolab-consul-3.ip}",
  }
}