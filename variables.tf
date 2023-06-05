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

variable "vpc_name" {
  type        = string
  description = "The name of the VPC."
  default     = "wsf-vpc"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
  default     = "intel-test01-sn"
}

variable "zone" {
  type        = string
  description = "The zone where the resources will be created."
  default     = "us-south-1"
}

variable "ipv4_cidr_block" {
  type        = string
  description = "The CIDR block for the subnet."
  default     = "10.240.0.0/24"
}

variable "security_group_name" {
  type        = string
  description = "The name of the security group."
  default     = "intel-test01-sg"
}

variable "security_group_description" {
  type        = string
  description = "The description of the security group."
  default     = "Test security group"
}

variable "remote_ip_prefix" {
  type        = string
  description = "The CIDR block for remote access."
  default     = "0.0.0.0/0"
}

variable "protocol" {
  type        = string
  description = "The protocol for remote access."
  default     = "tcp"
}

variable "port_min" {
  type        = number
  description = "The minimum port number for remote access."
  default     = 22
}

variable "port_max" {
  type        = number
  description = "The maximum port number for remote access."
  default     = 22
}

variable "ssh_key_name" {
  type        = string
  description = "The name of the SSH key."
  default     = "wsf-key01"
}

variable "ssh_key_public" {
  type        = string
  description = "Public key to use when generating SSH Key"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBzaaVccW+zXSRS6qK9yNvGYTHE2GCkguHWCKI7qzYP2eKp4iusJqK0ScwMtkKctmH/TWktT6p3/K8sunnupcwa4brx1Ua64hKdvTWs1hw/HlxYU5ZSOjbuKJJrRsu117CnjSNyW+NBF3roDMXLE7ygvFNOx+UaDdZifwGIA7EYu/Afo3vVjb4EETW0l+KDVE0XWRdkc7eK6J3RqSEzVaNgqdQDYHqaveFQg6LiCQ/Xc8+OpXjVbJT7SirdwdSCpRPfSJhVpp9lkKa/gqKjWUtWUzZbLBBt2M0T4PgsdC7gmhPlB6j95EVxTGGNQgGFZsxAEFe4klJnpz7P/9o6WDB0KeJRndiml6l/Evj+GR0NZA9R5qFVbPR2cJpNSAOX6S6aqssKtHeIF02vHhXT4Hq0ctH5ly/OP0NupkZYgu9A4wY46WRcoMu/U4gB6Q9AQ4AcaxUVRsIOYSZE0p++X3/WsOuNAEFDi39dnKyEnoRL/SJkUFUFd41OhQfLGWyxoU="
}

variable "instance_name" {
  description = "The name of the instance."
  default     = "wsf-test01-vm"
}

variable "image_name" {
  type        = string
  description = "The name of the image."
  default     = "r006-c2c24ac1-b03d-4427-85cf-92e95d4aa658"
  #Look this up from the CLI
}

variable "profile_name" {
  type        = string
  description = "The name of the profile."
  default     = "bx2-2x8"
}


########################
####     Other      ####
########################