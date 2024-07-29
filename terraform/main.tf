# Define required providers
terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.44.0"
    }
  }
}

provider "openstack" {
  user_name   = var.os_user_name
  tenant_name = var.os_tenant_name
  password    = var.os_password
  auth_url    = var.os_auth_url
  region      = var.os_region_name
  user_domain_name = var.os_user_domain_name
}

resource "openstack_networking_secgroup_v2" "chatbot_security_group" {
  name        = "chatbot_security_group"
  description = "Groupe de sécurité pour le chatbot"
}

resource "openstack_networking_secgroup_rule_v2" "ping_rule_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "ping_rule_egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "nginx_rule_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "nginx_rule_egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "nginx_ssl_rule_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "nginx_ssl_rule_egress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "postgres_rule_egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5432
  port_range_max    = 5432
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "postgres_rule_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5432
  port_range_max    = 5432
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "backend_rule_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3001
  port_range_max    = 3001
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "backend_rule_egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3001
  port_range_max    = 3001
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "ssh_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.chatbot_security_group.id
}

resource "openstack_compute_instance_v2" "instance" {
  name            = var.name
  image_id        = var.image_id
  flavor_id       = var.flavor_id
  security_groups = ["default", openstack_networking_secgroup_v2.chatbot_security_group.name]

  network {
    name = var.network_name
  }

  user_data = templatefile("${path.module}/cloud_init.yaml", {
    ssh_key = var.public_key
    user    = var.username
  })
}
