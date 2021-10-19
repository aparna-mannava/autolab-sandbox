terraform {
  backend "s3" {}
}

locals {
  product     = "cfrm"
  environment = "production"
  datacenter  = "dc4"
  facts       = {
    "bt_customer" = "dgbcs"
    "bt_deployment_mode" = "blue"
    "bt_env" = ""
    "bt_infra_cluster" = "dc4-aza-ntnx-04"
	"bt_infra_network" = "dc4-dgb-dgb-production-web"
    "bt_product" = "cfrm"
    "bt_start_httpd" = "Yes"
    "bt_server_mode" = "web"
    "bt_tier" = "prod"
    "cpus" = "2"
    "firewall_group" = "CFRM_PR_WEB"
    "foreman_hostgroup" = "BT CFRM SP BG Web Server"
    "lob" = "CFRM"
    "memory" = "8192"
    "os_version" = "rhel7"
    "web01_hostname" = "us00vlweb00006"
    "web02_hostname" = "us00vlweb00007"
  }

  web01facts    = {
    "bt_customer" = "${local.facts.bt_customer}"
    "bt_product" = "${local.facts.bt_product}"
    "bt_tier" = "${local.facts.bt_tier}"
    "bt_deployment_mode" = "${local.facts.bt_deployment_mode}"
    "bt_env" = "${local.facts.bt_env}"
    "bt_server_mode" = "${local.facts.bt_server_mode}"
    "bt_server_number" = "01"
    "bt_alias" = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode}01"
    "bt_start_httpd" = "${local.facts.bt_start_httpd}"
  }
  web02facts    = {
    "bt_customer" = "${local.facts.bt_customer}"
    "bt_product" = "${local.facts.bt_product}"
    "bt_tier" = "${local.facts.bt_tier}"
    "bt_deployment_mode" = "${local.facts.bt_deployment_mode}"
    "bt_env" = "${local.facts.bt_env}"
    "bt_server_mode" = "${local.facts.bt_server_mode}"
    "bt_server_number" = "02"
    "bt_alias" = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.facts.bt_server_mode}02"
    "bt_start_httpd" = "${local.facts.bt_start_httpd}"
  }
}

module "webserver_1" {
    source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
    hostname             = "${local.facts.web01_hostname}"
    alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.web01facts.bt_server_mode}${local.web01facts.bt_server_number}"
    bt_infra_network     = "${local.facts.bt_infra_network}"
    bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
    os_version           = "${local.facts.os_version}"
    cpus                 = "${local.facts.cpus}"
    memory               = "${local.facts.memory}"
    foreman_environment  = local.environment
    foreman_hostgroup    = "${local.facts.foreman_hostgroup}"
    firewall_group       = "${local.facts.firewall_group}"
    datacenter           = local.datacenter
    lob                  = "${local.facts.lob}"
    external_facts       = local.web01facts
    additional_disks     = {
      1 = "50",
      2 = "100"
    }
}

module "webserver_2" {
    source               = "git::https://us-pr-stash.saas-p.com/scm/trrfrm/terraform-module-infrastructure.git?ref=master"
    hostname             = "${local.facts.web02_hostname}"
    alias                = "${local.facts.bt_product}-${local.facts.bt_customer}-${local.facts.bt_tier}${local.facts.bt_env}-${local.web02facts.bt_server_mode}${local.web02facts.bt_server_number}"
    bt_infra_network     = "${local.facts.bt_infra_network}"
    bt_infra_cluster     = "${local.facts.bt_infra_cluster}"
    os_version           = "${local.facts.os_version}"
    cpus                 = "${local.facts.cpus}"
    memory               = "${local.facts.memory}"
    foreman_environment  = local.environment
    foreman_hostgroup    = "${local.facts.foreman_hostgroup}"
    firewall_group       = "${local.facts.firewall_group}"
    datacenter           = local.datacenter
    lob                  = "${local.facts.lob}"
    external_facts       = local.web02facts
    additional_disks     = {
      1 = "50",
      2 = "100"
    }
}

output "webserver_1" {
    value = {
      "fqdn"  = "${module.webserver_1.fqdn}",
      "alias" = "${module.webserver_1.alias}",
      "ip"    = "${module.webserver_1.ip}",
    }
}

output "webserver_2" {
    value = {
      "fqdn"  = "${module.webserver_2.fqdn}",
      "alias" = "${module.webserver_2.alias}",
      "ip"    = "${module.webserver_2.ip}",
    }
}