terraform {
backend "s3" {}
}

locals {
    etcd_servers = ["us01vlfmed021","us01vlfmed022","us01vlfmed023"]
    hapg_servers = ["us01vlfmpg021","us01vlfmpg022","us01vlfmpg023"]
    haproxy_server = ["us01vlfmpxy021"]
    etcd_hosts_p = ["'us01vlfmed021.auto.saas-n.com','us01vlfmed022.auto.saas-n.com','us01vlfmed023.auto.saas-n.com'"]
    domain = "auto.saas-n.com"
    tier = "autolab"
    bt_env = "3"
    bt_product = "fmcloud"
    lob = "FMCLOUD"
    hostgroup = "BT HA PG Server" #######. HOST GROUP
    environment = "master"
    cluster = "ny5-aza-ntnx-19"
    network = "ny2-autolab-app-ahv"
    facts = {
        "bt_pg_version"           = "12"
        "bt_env" = "${local.bt_env}"
        "bt_tier" = "${local.tier}"
        "bt_product" = "${local.bt_product}"
        "bt_etcd_cluster_members" = ["${local.etcd_servers[0]}.${local.domain}", "${local.etcd_servers[1]}.${local.domain}", "${local.etcd_servers[2]}.${local.domain}"]
        "bt_hapg_cluster_members" = ["${local.hapg_servers[0]}.${local.domain}", "${local.hapg_servers[1]}.${local.domain}", "${local.hapg_servers[2]}.${local.domain}"]
        "bt_hapg_node1" = "${local.hapg_servers[0]}.${local.domain}"
        "bt_hapg_node2" = "${local.hapg_servers[1]}.${local.domain}"
        "bt_hapg_node3" = "${local.hapg_servers[2]}.${local.domain}"
    }
}

module "ny2_autolab_hapg_0" {
    source = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
    hostname = "${local.hapg_servers[0]}"
    bt_infra_cluster = local.cluster
    bt_infra_network = local.network
    lob = local.lob
    foreman_hostgroup = "BT HA PG Server"
    foreman_environment = local.environment
    os_version = "rhel8"
    cpus = "8"
    memory = "16384"
    external_facts = local.facts
    datacenter = "ny2"
    additional_disks = {
        1 = "100", ### goes to rootvg
        2 = "150", ###. size of disk
        3 = "150", ### size of #2 disk
    }
}

module "ny2_autolab_hapg_1" {
    source = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
    hostname = "${local.hapg_servers[1]}"
    bt_infra_cluster = local.cluster
    bt_infra_network = local.network
    foreman_hostgroup = "BT HA PG Server"
    foreman_environment = local.environment
    lob = local.lob
    os_version = "rhel8"
    cpus = "8"
    memory = "16384"
    external_facts = local.facts
    datacenter = "ny2"
    additional_disks = {
        1 = "100",
        2 = "150",
        3 = "150",
    }
}

module "ny2_autolab_hapg_2" {
    source = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
    hostname = "${local.hapg_servers[2]}"
    bt_infra_cluster = local.cluster
    bt_infra_network = local.network
    foreman_hostgroup = "BT HA PG Server"
    foreman_environment = local.environment
    lob = local.lob
    os_version = "rhel8"
    cpus = "8"
    memory = "16384"
    external_facts = local.facts
    datacenter = "ny2"
    additional_disks = {
        1 = "100",
        2 = "150",
        3 = "150",
    }
}

module "ny2_autolab_haproxy_1" {
    source = "git::https://gitlab.saas-p.com/shared/terraform-modules/terraform-module-infrastructure.git?ref=master"
    hostname = "${local.haproxy_server[0]}"
    bt_infra_cluster = local.cluster
    bt_infra_network = local.network
    foreman_hostgroup = "BT Patroni HA Proxy"
    foreman_environment = local.environment
    lob = local.lob
    os_version = "rhel7"
    cpus = "2"
    memory = "4096"
    external_facts = local.facts
    datacenter = "ny2"
    additional_disks = {
        1 = "50",
        2 = "10",
    }
}

output "ny2_autolab_hapg_0" {
    value = {
        "fqdn" = "${module.ny2_autolab_hapg_0.fqdn}",
        "alias" = "${module.ny2_autolab_hapg_0.alias}",
        "ip" = "${module.ny2_autolab_hapg_0.ip}",
    }
}

output "ny2_autolab_hapg_1" {
    value = {
        "fqdn" = "${module.ny2_autolab_hapg_1.fqdn}",
        "alias" = "${module.ny2_autolab_hapg_1.alias}",
        "ip" = "${module.ny2_autolab_hapg_1.ip}",
    }
}

output "ny2_autolab_hapg_2" {
    value = {
        "fqdn" = "${module.ny2_autolab_hapg_2.fqdn}",
        "alias" = "${module.ny2_autolab_hapg_2.alias}",
        "ip" = "${module.ny2_autolab_hapg_2.ip}",
    }
}

output "ny2_autolab_haproxy_1" {
    value = {
        "fqdn" = "${module.ny2_autolab_haproxy_1.fqdn}",
        "alias" = "${module.ny2_autolab_haproxy_1.alias}",
        "ip" = "${module.ny2_autolab_haproxy_1.ip}",
    }
}