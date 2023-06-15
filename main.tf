data "ibm_is_image" "image" {
  name = var.image_name
}

data "ibm_is_subnet" "subnet" {
  identifier = var.subnet_id
}

#Creates a new security group with the instance name-group as the group name rather than the standard IBM random Group names
resource "ibm_is_security_group" "vpcinstance" {
  name           = "${var.name}-group"
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
}

#Allows SSH inbound to a new security group that gets created.
resource "ibm_is_security_group_rule" "ssh_inbound" {
  group     = ibm_is_security_group.vpcinstance.id
  direction = "inbound"
  remote    = var.allow_ssh_from
  tcp {
    port_min = 22
    port_max = 22
  }
}

#Outbound SSH to the public ip that gets assigned
resource "ibm_is_security_group_rule" "ssh_to_self_public_ip" {
  count = var.create_public_ip ? 1 : 0

  group     = ibm_is_security_group.vpcinstance.id
  direction = "outbound"
  remote    = ibm_is_floating_ip.vpcinstance[0].address
  tcp {
    port_min = 22
    port_max = 22
  }
}

# Adds default rules to the new security group
resource "ibm_is_security_group_rule" "additional_all_rules" {
  for_each = {
    for rule in var.security_group_rules : rule.name => rule if lookup(rule, "tcp", null) == null && lookup(rule, "udp", null) == null && lookup(rule, "icmp", null) == null
  }
  group      = ibm_is_security_group.vpcinstance.id
  direction  = each.value.direction
  remote     = each.value.remote
  ip_version = lookup(each.value, "ip_version", null)
}

resource "ibm_is_security_group_rule" "additional_tcp_rules" {
  for_each = {
    for rule in var.security_group_rules : rule.name => rule if lookup(rule, "tcp", null) != null
  }
  group      = ibm_is_security_group.vpcinstance.id
  direction  = each.value.direction
  remote     = each.value.remote
  ip_version = lookup(each.value, "ip_version", null)

  tcp {
    port_min = each.value.tcp.port_min
    port_max = each.value.tcp.port_max
  }
}

resource "ibm_is_security_group_rule" "additional_udp_rules" {
  for_each = {
    for rule in var.security_group_rules : rule.name => rule if lookup(rule, "udp", null) != null
  }
  group      = ibm_is_security_group.vpcinstance.id
  direction  = each.value.direction
  remote     = each.value.remote
  ip_version = lookup(each.value, "ip_version", null)

  udp {
    port_min = each.value.udp.port_min
    port_max = each.value.udp.port_max
  }
}

resource "ibm_is_security_group_rule" "additional_icmp_rules" {
  for_each = {
    for rule in var.security_group_rules : rule.name => rule if lookup(rule, "icmp", null) != null
  }
  group      = ibm_is_security_group.vpcinstance.id
  direction  = each.value.direction
  remote     = each.value.remote
  ip_version = lookup(each.value, "ip_version", null)

  icmp {
    type = each.value.icmp.type
    code = lookup(each.value.icmp, "code", null) == null ? null : each.value.icmp.code
  }
}

resource "ibm_is_instance" "vpcinstance" {
  name           = var.name
  vpc            = var.vpc_id
  zone           = data.ibm_is_subnet.subnet.zone
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = var.ssh_key_ids
  resource_group = var.resource_group_id

  # If you want to pass user data to the instance upon creation
  #user_data = var.init_script != "" ? var.init_script : file("${path.module}/init-script-ubuntu.sh")

  primary_network_interface {
    name              = "eth1"
    subnet            = data.ibm_is_subnet.subnet.id
    allow_ip_spoofing = false
    security_groups   = [ibm_is_security_group.vpcinstance.id]
  }

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }

  # Names the disk volume the same as the VM instance name
  boot_volume {
    name = "${var.name}-boot"
  }

  tags = var.tags
}

#Assigns an IP to the network interface
resource "ibm_is_floating_ip" "vpcinstance" {
  count = var.create_public_ip ? 1 : 0

  name           = "${var.name}-ip"
  target         = ibm_is_instance.vpcinstance.primary_network_interface[0].id
  resource_group = var.resource_group_id

  tags = var.tags
}

