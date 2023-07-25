########################
####     Intel      ####
########################

# See policies.md, Intel recommends the 4th Generation Intel® Xeon® Platinum (Saphire Rapids) based instances.  At the time of the creation of the module only the 
# 2nd Generation Intel® Xeon® Platinum (Cascade Lake) instances are available.
#
# The policies.md will be updated when Saphire Rapids instances become available.
#
# Balanced Optimized:
#  bx2-2x8,bx2d-2x8,bx2-4x16,bx2d-4x16,bx2-8x32,bx2d-8x32,bx2-16x64,bx2d-16x64,bx2-32x128,bx2d-32x128,bx2-48x192,bx2d-48x192,bx2-64x256,bx2d-64x256,bx2-96x384,,bx2d-96x384,bx2-128x512,bx2d-128x512
# Compute Optimized:
#  cx2-2x4,cx2d-2x4,cx2-4x8,cx2d-4x8,cx2-8x16,cx2d-8x16,cx2-16x32,cx2d-16x32,cx2-32x64,cx2d-32x64,cx2-48x96,cx2d-48x96,cx2-64x128,cx2d-64x128,cx2-96x192,cx2d-96x192,cx2-128x256,cx2d-128x256
# Memory Optimized:
#  mx2-2x16,mx2d-2x16,mx2-4x32,mx2d-4x32,mx2-8x64,mx2d-8x64,mx2-16x128,mx2d-16x128,mx2-32x256,mx2d-32x256,mx2-48x384,mx2d-48x384,mx2-64x512,mx2d-64x512,mx2-96x768,mx2d-96x768,mx2-128x1024,mx2d-128x1024,
# Storage Optimized:
#  ox2-2x16,ox2-4x32,ox2-8x64,ox2-16x128,ox2-32x256,ox2-64x512,ox2-96x768,ox2-128x1024
# Very High Memory Optimized:
#  vx2d-2x28,vx2d-4x56,vx2d-8x112,vx2d-16x224,vx2d-44x616,vx2d-88x1232,vx2d-144x2016,vx2d-176x2464
# Ultra High Memory Optimized:
#  ux2d-2x56,ux2d-4x112,ux2d-8x224,ux2d-16x448,ux2d-36x1008,ux2d-48x1344,ux2d-72x2016,ux2d-100x2800,ux2d-200x5600
# GPU Optimized:
#  gx2-8x64x1v100,gx2-16x128x2v100,gx2-32x256x2v100
#
# See more:
# https://cloud.ibm.com/docs/vpc?topic=vpc-profiles&interface=ui

########################
####    Required    ####
########################

# In this block the code determines the minimum CPU platform based on the machine type that the use has selected. We always recommend our customers to use the 
# latest generation of Intel CPU platforms that are publicly available . As of the date of this repo creation, the General Purpose bx2-2x8 instances can be on either Ice Lake 
# or Cascade Lake for the same price. For better price and performance, we are recommendaing to use Intel Ice Lake instances where possible. 
#
# This module was created with the assumption that you have some infrastructure in place and you want to automate an Virtual server in an existing account/network.
# Assumptions:
#    VPC Exists in a Region
#    Subnet(s) Exists in the VPC
#    Resource Group Exist in the IBM Cloud Account
#    SSH Key(s) Exist in the Resource Group

variable "region" {
  type        = string
  description = "The region where the resources will be created."
  default     = "us-south"
}

variable "name" {
  type        = string
  default     = "vm01"
  description = "Name of the instance"
}

variable "resource_group_id" {
  type        = string
  description = "ID of the resource group that has the VPC, SSH key, etc."
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where to create the instance"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet in the VPC where to create the instance"
}

variable "ssh_key_ids" {
  type        = list(string)
  description = "List of SSH key IDs to inject into the instance.  This is not the public key itself, but just the key's IBM ID"

}

########################
####    Other   ####
########################

variable "image_name" {
  type        = string
  description = "Name of the OS image to use for the instance"
  default     = "ibm-ubuntu-22-04-2-minimal-amd64-1"
}

variable "init_script" {
  type        = string
  default     = ""
  description = "Script to run during the instance initialization. Defaults to an Ubuntu specific script when set to empty"
}

variable "profile_name" {
  type        = string
  description = "Instance profile for an Intel based Xeon Processor to use for the instance"
}

variable "create_public_ip" {
  type        = bool
  description = "Set whether to allocate a public IP address for the instance"
  default     = true
  #Set this to false if you do not want your instance to have a Public IP
}

# Security Group Created allows inbound SSH from 0.0.0.0/0


variable "allow_ssh_from" {
  type        = string
  description = "An IP address, a CIDR block, or a single security group identifier to allow incoming SSH connection to the instance"
  default     = "0.0.0.0/0"
}


# Security Group Created allows outbound ports
variable "allow_outbound" {
  type        = string
  description = "An IP address, a CIDR block, or a single security group identifier to allow outbound network connections"
  default     = "0.0.0.0/0"
}

variable "security_group_rules" {
  description = "List of security group rules to set on the new security group created, in addition to the SSH rules"
  default = [
    # Adjust rules below if you want specific inbound our outbound rules in the SG that gets created.
    # {
    #   name      = "http_outbound"
    #   direction = "outbound"
    #   remote    = "0.0.0.0/0"
    #   tcp = {
    #     port_min = 80
    #     port_max = 80
    #   }
    # },
    # {
    #   name      = "https_outbound"
    #   direction = "outbound"
    #   remote    = "0.0.0.0/0"
    #   tcp = {
    #     port_min = 443
    #     port_max = 443
    #   }
    # },
    # {
    #   name      = "dns_outbound"
    #   direction = "outbound"
    #   remote    = "0.0.0.0/0"
    #   udp = {
    #     port_min = 53
    #     port_max = 53
    #   }
    # },
    {
      name      = "icmp_outbound"
      direction = "outbound"
      remote    = "0.0.0.0/0"
      icmp = {
        type = 8
      }
    }
  ]
}

variable "tags" {
  type        = list(string)
  description = "List of tags to add on all created resources"
  default     = []
}

variable "all_auto_delete_volume" {
  type        = bool
  description = "If set to true, automatically deletes the volumes that are attached to an instance."
  default     = null
}

variable "availability_policy_host_failure" {
  type        = string
  description = "The availability policy to use for this virtual server instance. The action to perform if the compute host experiences a failure. Supported values are restart and stop."
  default     = null
}

variable "boot_volume_size" {
  type        = number
  description = "The size of the boot volume.(The capacity of the volume in gigabytes. This defaults to minimum capacity of the image and maximum to 250."
  default     = null
}

variable "boot_volume_auto_delete_volume" {
  type        = string
  description = "If set to true, when deleting the instance the volume will also be deleted."
  default     = null
}

variable "boot_volume_encryption" {
  type        = string
  description = "The type of encryption to use for the boot volume."
  default     = null
}

variable "additional_volumes" {
  default = []
  type    = list(object({
    volume_name    = string
    volume_profile = string
    size           = number
  }))
}


variable "dedicated_host" {
  type        = string
  description = "The placement restrictions to use the virtual server instance. Unique ID of the dedicated host where the instance id placed."
  default     = null
}

variable "dedicated_host_group" {
  type        = string
  description = "The placement restrictions to use for the virtual server instance. Unique ID of the dedicated host group where the instance is placed."
  default     = null
}

variable "placement_group" {
  type        = string
  description = "Unique Identifier of the Placement Group for restricting the placement of the instance."
  default     = null
}

variable "instance_template" {
  type        = string
  description = "ID of the instance template to create the instance from."
  default     = null
}

variable "access_tags" {
  type        = list(any)
  description = " A list of access management tags to attach to the instance."
  default     = []
}

variable "total_volume_bandwidth" {
  type        = number
  description = "The amount of bandwidth (in megabits per second) allocated exclusively to instance storage volumes."
  default     = null
}


variable "user_data" {
  type        = string
  description = "User data to transfer to the instance."
  default     = null
}

variable "existing_volume_ids" {
  type        = list(string)
  description = "A list of maps describing the volumes for each instance"
  default     = []
}

variable "create_volume" {
  type        = number
  description = "If you want to create a volume, change from 0"
  default     = 0
}

variable "volume_name" {
  type        = string
  description = "Name of the volume to create"
  default     = null
}

variable "volume_profile" {
  type        = string
  description = "Profile to use for the volume"
  default     = null
}
