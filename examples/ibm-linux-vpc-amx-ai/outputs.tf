output "id" {
  description = "The ID of the instance."
  value       = try(module.ibm_is_instance.id, "")
}

output "bandwidth" {
  description = "The total bandwidth (in megabits per second) shared across the instance's network interfaces and storage volumes."
  value       = try(module.ibm_is_instance.bandwidth, "")
}

output "boot_volume" {
  description = "A list of boot volumes that the instance uses."
  value       = try(module.ibm_is_instance.boot_volume, "")
}

output "crn" {
  description = "The CRN of the instance."
  value       = try(module.ibm_is_instance.crn, "")
}

output "disks" {
  description = "The collection of the instance's disks."
  value       = try(module.ibm_is_instance.disks, "")
}

output "gpu" {
  description = "A list of GPUs that are assigned to the instance."
  value       = try(module.ibm_is_instance.gpu, "")
}

output "placement_target" {
  description = "The placement restrictions for the virtual server instance."
  value       = try(module.ibm_is_instance.placement_target, "")
}

output "memory" {
  description = "The amount of memory that is allocated to the instance in gigabytes."
  value       = try(module.ibm_is_instance.memory, "")
}

output "network_interface" {
  description = "The network interface associated with the instance."
  value       = try(module.ibm_is_instance.network_interfaces, "")
}

output "primary_network_interface" {
  description = "A list of primary network interfaces that are attached to the instance."
  value       = try(module.ibm_is_instance.primary_network_interface, "")
}

output "status" {
  description = "The status of the instance."
  value       = try(module.ibm_is_instance.status, "")
}

output "status_reasons" {
  description = "Array of reasons for the current status."
  value       = try(module.ibm_is_instance.status_reasons, "")
}

output "total_network_badwidth" {
  description = "The amount of bandwidth (in megabits per second) allocated exclusively to instance network interfaces."
  value       = try(module.ibm_is_instance.total_network_bandwidth, "")
}

output "volume_attachments" {
  description = "A list of volume attachments for the instance."
  value       = try(module.ibm_is_instance.volume_attachments, "")
}

output "vcpu" {
  description = "The number of virtual CPUs assigned to the instance."
  value       = try(module.ibm_is_instance.vcpu, "")
}

output "name" {
  description = "The name of the instance."
  value       = try(module.ibm_is_instance.name, "")
}


