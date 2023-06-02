provider "ibm" {
  region     = var.region
}

resource "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}

resource "ibm_is_subnet" "subnet" {
  name            = var.subnet_name
  vpc             = ibm_is_vpc.vpc.id
  zone            = var.zone
  ipv4_cidr_block = var.ipv4_cidr_block
}

resource "ibm_is_ssh_key" "ssh_key" {
  name        = var.ssh_key_name
  public_key  = var.ssh_key_public
}

resource "ibm_is_security_group" "security_group" {
  name        = var.security_group_name
  vpc         = ibm_is_vpc.vpc.id
#  description = var.security_group_description
}

resource "ibm_is_security_group_rule" "security_group_rule" {
  group   = ibm_is_security_group.security_group.id
  direction     = "inbound"
  remote        = var.remote_ip_prefix
  depends_on    = [ibm_is_security_group.security_group]
  
  tcp {
    port_min      = var.port_min
    port_max      = var.port_max
  }
}

resource "ibm_is_instance" "instance" {
  name         = var.instance_name
  image        = var.image_name
  profile      = var.profile_name
  vpc          = ibm_is_vpc.vpc.id
  zone         = var.zone
  keys         = [ibm_is_ssh_key.ssh_key.id]

  primary_network_interface {
    subnet                = ibm_is_subnet.subnet.id
    allow_ip_spoofing     = false
  }

  network_interfaces {
    name   = "eth1"
    subnet = ibm_is_subnet.subnet.id
    allow_ip_spoofing = false
  }

  # primary_network_interface {
  #   name              = "eth0"
  #   subnet            = ibm_is_subnet.subnet.id
  #   security_groups   = [ibm_is_security_group.security_group.id]
  #   allow_ip_spoofing = false

  #   primary_ip {
  #     address   = ibm_is_subnet.subnet.ipv4_cidr_block
  #   }
  # }
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}
