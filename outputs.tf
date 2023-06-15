
output "vpcinstance_id" {
  value       = ibm_is_instance.vpcinstance.id
  description = "ID of the vpcinstance virtual server instance"
}

output "vpcinstance_private_ip" {
  value       = ibm_is_instance.vpcinstance.primary_network_interface[0].primary_ip.0.address
  description = "Private IP address of the vpcinstance virtual server instance"
}

output "vpcinstance_public_ip" {
  value       = var.create_public_ip ? ibm_is_floating_ip.vpcinstance[0].address : null
  description = "Public IP address of the vpcinstance virtual server instance, null if none was allocated."
}

output "vpcinstance_security_group_id" {
  value       = ibm_is_security_group.vpcinstance.id
  description = "ID of the new security group that gets created and assigned to the vpcinstance interface"
}

output "vpcinstance_network_interface_ids" {
  value       = ibm_is_instance.vpcinstance.primary_network_interface[*].id
  description = "ID of the primary_network_interface for the vpcinstance instance"
}
