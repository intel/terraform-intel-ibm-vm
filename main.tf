provider "ibm" {
  region     = var.region
}

resource "ibm_is_vpc" "vpc" {
  name = var.vpc_name
  ## Need to determine if this needs to be looked up or created new or something else
}

resource "ibm_is_subnet" "subnet" {
  name            = var.subnet_name
  vpc             = ibm_is_vpc.vpc.id
  zone            = var.zone
  ipv4_cidr_block = var.ipv4_cidr_block
  ## Need to determine what ranges are valid for VPC instance
  ## Need to validate that we can reuse an existing range
}

resource "ibm_is_ssh_key" "ssh_key" {
  name        = var.ssh_key_name
  public_key  = var.ssh_key_public
  ## Find a better way
  ## https://www.netexpertise.eu/en/devops/terraform/terraform-shared-resources-ssh-keys-case-study.html
}

resource "ibm_is_security_group" "security_group" {
  name        = var.security_group_name
  vpc         = ibm_is_vpc.vpc.id
#  description = var.security_group_description
## Flesh this one out and figure out valid values?
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
  ## Flesh this one out and figure out valid values
  ## What settings should be used in the provider version we are targeting?
}

resource "ibm_is_instance" "instance" {
  name         = var.instance_name #random numbers?
  image        = var.image_name #OS and version
  profile      = var.profile_name #Instance size, will need policy checks
}

resource "ibm_is_instance" "instance" {
  name         = var.instance_name
  image        = var.image_name
  profile      = var.profile_name
  vpc          = ibm_is_vpc.vpc.id
  zone         = var.zone
  keys         = [ibm_is_ssh_key.ssh_key.id]
 
  # Flesh the network interface and primary_network_interface sections

  primary_network_interface {
    subnet                = ibm_is_subnet.subnet.id
    allow_ip_spoofing     = false
  }

  network_interfaces {
    name   = "eth1"
    subnet = ibm_is_subnet.subnet.id
    allow_ip_spoofing = false
  }

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}
