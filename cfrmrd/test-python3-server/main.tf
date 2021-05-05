terraform {
  backend "s3" {}
}

locals {
    facts       = {
      "bt_customer" = "cfrmrd"
      "bt_product"  = "cfrmrd"
      "bt_tier"     = "dev"
      "bt_env"      = "autolab"
    }
    test_app_server_facts    = {
      "bt_role" = "python"
      "bt_customer" = "${local.facts.bt_customer}"
      "bt_product" = "${local.facts.bt_product}"
      "bt_tier" = "${local.facts.bt_tier}"
      "bt_env" = "${local.facts.bt_env}"
     }
}

module "test_python3_server" {
  source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
  hostname             = "us01vlcfrmrd399"
  alias                = "cfrmx-python-server"
  bt_infra_network     = "ny2-autolab-app-ahv"
  bt_infra_cluster     = "ny2-aze-ntnx-12"
  cpus                 = "4"
  memory               = "8192"
  os_version           = "rhel7"
  external_facts       = local.test_app_server_facts
  foreman_environment  = "feature_test_python3_server"
  foreman_hostgroup    = "CFRMRD Python"
  lob                  = "CFRM"
  datacenter           = "ny2"
  additional_disks     = {
    1 = "50",
	2 = "100"
  }
}

output "test_python3_server" {
  value = {
    "fqdn"  = "${module.test_python3_server.fqdn}",
    "alias" = "${module.test_python3_server.alias}",
    "ip"    = "${module.test_python3_server.ip}"
  }
}
