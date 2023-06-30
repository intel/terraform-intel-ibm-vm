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

#Allows all ports outbound to a new security group that gets created.
resource "ibm_is_security_group_rule" "allow_outbound" {
  group     = ibm_is_security_group.vpcinstance.id
  direction = "outbound"
  remote    = var.allow_outbound
  tcp {
    port_min = 1
    port_max = 65535
  }
}

resource "ibm_is_volume" "volume" {
  count = var.create_volume == 0 ? length(var.existing_volume_ids) : var.create_volume 
   name = var.volume_name
   profile = var.volume_profile
   zone = data.ibm_is_subnet.subnet.zone
}

################################################################################
# Instance
################################################################################

resource "ibm_is_instance" "vpcinstance" {
  name           = var.name
  vpc            = var.vpc_id
  zone           = data.ibm_is_subnet.subnet.zone
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = var.ssh_key_ids
  resource_group = var.resource_group_id

  # If you want to pass user data to the instance upon creation this is the code to add that to your terraform script.
  #user_data = var.init_script != "" ? var.init_script : file("${path.module}/init-script-ubuntu.sh")

  user_data                        = var.user_data
  access_tags                      = var.access_tags
  auto_delete_volume               = var.all_auto_delete_volume
  availability_policy_host_failure = var.availability_policy_host_failure
  instance_template                = var.instance_template
  dedicated_host                   = var.dedicated_host
  dedicated_host_group             = var.dedicated_host_group
  placement_group                  = var.placement_group
  total_volume_bandwidth           = var.total_volume_bandwidth

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

  volumes = var.create_volume ==0 ? var.existing_volume_ids : ibm_is_volume.volume.*.id

 # volumes = var.volumes[]
  # dynamic "volumes" {
  #   for_each = var.volumes
  #   content {
  #     name           = lookup(volumes.value, "name", null)
  #     profile        = lookup(volumes.value, "profile", null)
  #     capacity       = lookup(volumes.value, "capacity", null)
  #     iops           = lookup(volumes.value, "iops", null)
  #     encryption_key = lookup(volumes.value, "encryption_key", null)
  #   }
  # }


  # Names the disk volume the same as the VM instance name
  boot_volume {
    name               = "${var.name}-boot"
    auto_delete_volume = var.boot_volume_auto_delete_volume
    encryption         = var.boot_volume_encryption
    size               = var.boot_volume_size
    tags               = var.tags

  }

  tags = var.tags
}

#Assigns an IP to the network interface and names it with the instance name

resource "ibm_is_floating_ip" "vpcinstance" {
  count = var.create_public_ip ? 1 : 0

  name           = "${var.name}-ip"
  target         = ibm_is_instance.vpcinstance.primary_network_interface[0].id
  resource_group = var.resource_group_id

  tags = var.tags
}


#The following code is intended to provide you the code to be more specific with the Security Group rules that you want to create with terraform.
#Outbound SSH to the public ip that gets assigned
resource "ibm_is_security_group_rule" "ssh_to_self_public_ip" {
  count = var.create_public_ip ? 1 : 0

  group     = ibm_is_security_group.vpcinstance.id
  direction = "outbound"
  remote    = ibm_is_floating_ip.vpcinstance[0].address
  tcp {
    port_min = 1
    port_max = 65535
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

