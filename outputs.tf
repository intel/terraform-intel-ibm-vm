output "id" {
  description = "The ID of the instance."
  value       = try(ibm_is_instance.vpcinstance.id, "")
}

output "bandwidth" {
  description = "The total bandwidth (in megabits per second) shared across the instance's network interfaces and storage volumes."
  value       = try(ibm_is_instance.vpcinstance.bandwidth, "")
}

output "boot_volume" {
  description = "A list of boot volumes that the instance uses."
  value       = try(ibm_is_instance.vpcinstance.boot_volume, "")
}

output "crn" {
  description = "The CRN of the instance."
  value       = try(ibm_is_instance.vpcinstance.crn, "")
}

output "disks" {
  description = "The collection of the instance's disks."
  value       = try(ibm_is_instance.vpcinstance.disks, "")
}

output "gpu" {
  description = "A list of GPUs that are assigned to the instance."
  value       = try(ibm_is_instance.vpcinstance.gpu, "")
}

output "placement_target" {
  description = "The placement restrictions for the virtual server instance."
  value       = try(ibm_is_instance.vpcinstance.placement_target, "")
}

output "memory" {
  description = "The amount of memory that is allocated to the instance in gigabytes."
  value       = try(ibm_is_instance.vpcinstance.memory, "")
}

output "network_interface" {
  description = "The network interface associated with the instance."
  value       = try(ibm_is_instance.vpcinstance.network_interfaces, "")
}

output "primary_network_interface" {
  description = "A list of primary network interfaces that are attached to the instance."
  value       = try(ibm_is_instance.vpcinstance.primary_network_interface, "")
}

output "status" {
  description = "The status of the instance."
  value       = try(ibm_is_instance.vpcinstance.status, "")
}

output "status_reasons" {
  description = "Array of reasons for the current status."
  value       = try(ibm_is_instance.vpcinstance.status_reasons, "")
}

output "total_network_badwidth" {
  description = "The amount of bandwidth (in megabits per second) allocated exclusively to instance network interfaces."
  value       = try(ibm_is_instance.vpcinstance.total_network_bandwidth, "")
}

output "volume_attachments" {
  description = "A list of volume attachments for the instance."
  value       = try(ibm_is_instance.vpcinstance.volume_attachments, "")
}

output "vcpu" {
  description = "The number of virtual CPUs assigned to the instance."
  value       = try(ibm_is_instance.vpcinstance.vcpu, "")
}

output "name" {
  description = "The name of the instance."
  value       = try(ibm_is_instance.vpcinstance.name, "")
}


