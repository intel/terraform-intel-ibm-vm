########################
####     Intel      ####
########################

########################
####    Required    ####
########################

# variables.tf

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
  default     = "0d2599fc021c4bc19e8a330fd8286dbd"
  description = "ID of the resource group that has the VPC, SSH key, etc."
}

variable "vpc_id" {
  type        = string
  default     = "r006-df129de8-bde1-4cda-932c-32e9cdd2e7c7"
  description = "ID of the VPC where to create the instance"
}

variable "subnet_id" {
  type        = string
  default     = "0717-80ebe088-c5e7-4964-a4b9-ebb6acec6dcc"
  description = "ID of the subnet in the VPC where to create the instance"
}

variable "ssh_key_ids" {
  type        = list(string)
  description = "List of SSH key IDs to inject into the instance.  This is not the public key itself, but just the key's IBM ID"
  default     = ["r006-7c2c713a-257d-4dcd-8882-7aa5b3f5ad3e"]
}

variable "image_name" {
  type        = string
  default     = "ibm-ubuntu-22-04-2-minimal-amd64-1"
  description = "Name of the OS image to use for the instance"
}

# See if there is a way to have a variable where the user can enter an existing SG to when creating the VM
# variable "existing_sg" {
#   type=string
#   default = ""
#   description = "ID of the existing security group you want to add the instance "
# }

variable "init_script" {
  type        = string
  default     = ""
  description = "Script to run during the instance initialization. Defaults to an Ubuntu specific script when set to empty"
}

variable "profile_name" {
  type        = string
  description = "Instance profile for an Intel based Xeon Process to use for the instance"
  default     = "bx2-2x8"
}

variable "create_public_ip" {
  type        = bool
  description = "Set whether to allocate a public IP address for the instance"
  default     = true
}

# New SG created configurations below
variable "allow_ssh_from" {
  type        = string
  description = "An IP address, a CIDR block, or a single security group identifier to allow incoming SSH connection to the instance"
  default     = "0.0.0.0/0"
}

variable "security_group_rules" {
  description = "List of security group rules to set on the new security group created, in addition to the SSH rules"
  default = [
    {
      name      = "http_outbound"
      direction = "outbound"
      remote    = "0.0.0.0/0"
      tcp = {
        port_min = 80
        port_max = 80
      }
    },
    {
      name      = "https_outbound"
      direction = "outbound"
      remote    = "0.0.0.0/0"
      tcp = {
        port_min = 443
        port_max = 443
      }
    },
    {
      name      = "dns_outbound"
      direction = "outbound"
      remote    = "0.0.0.0/0"
      udp = {
        port_min = 53
        port_max = 53
      }
    },
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
  #Add Intel Tags here
}


########################
####     Other      ####
########################