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

variable "resource_group_id" {
  type        = string
  default     = "f7e7610930f04125b941786a7d40a663"
  description = "ID of the resource group where to create the bastion instance and security groups"
}

variable "vpc_id" {
  type        = string
  default     = "r006-ba164764-20a4-4ab3-9e23-6db6bef0757d"
  description = "ID of the VPC where to create the bastion"
}

variable "subnet_id" {
  type        = string
  default     = "0717-e2ce56e2-3d01-4558-9eef-d0349e5121f5"
  description = "ID of the subnet where to create the bastion instance"
}

variable "name" {
  type        = string
  default     = "vm01"
  description = "Name of the bastion instance"
}

variable "image_name" {
  type        = string
  default     = "ibm-ubuntu-22-04-2-minimal-amd64-1"
  description = "Name of the image to use for the bastion instance"
}

variable "init_script" {
  type        = string
  default     = ""
  description = "Script to run during the instance initialization. Defaults to an Ubuntu specific script when set to empty"
}

variable "profile_name" {
  type        = string
  description = "Instance profile to use for the bastion instance"
  default     = "bx2-2x8"
}

variable "ssh_key_ids" {
  type        = list(string)
  description = "List of SSH key IDs to inject into the bastion instance"
  default     = ["r006-7481e5d1-a6b3-4e99-a6c4-67ea9b69167a"]
}

variable "allow_ssh_from" {
  type        = string
  description = "An IP address, a CIDR block, or a single security group identifier to allow incoming SSH connection to the bastion"
  default     = "0.0.0.0/0"
}

variable "create_public_ip" {
  type        = bool
  description = "Set whether to allocate a public IP address for the bastion instance"
  default     = true
}

variable "security_group_rules" {
  # type = list(object({
  #   name=string,
  #   direction=string,
  #   remote=optional(string),
  #   ip_version=optional(string),
  #   tcp=optional(object({
  #     port_min=number,
  #     port_max=number
  #   })),
  #   udp=optional(object({
  #     port_min=number,
  #     port_max=number
  #   })),
  #   icmp=optional(object({
  #     type=number,
  #     code=optional(number)
  #   })),
  # }))
  description = "List of security group rules to set on the bastion security group in addition to the SSH rules"
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
}


########################
####     Other      ####
########################