<p align="center">
  <img src="https://github.com/intel/terraform-intel-ibm-vm/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## Terraform Intel IBM VM - Linux VM in VPC

This example creates an IBM virtual instance on Intel Cascade Lake CPU on a Linux Operating System in a VPC you specify. The VPC id has to be passed in this module as a variable. This module is configured to create the VM instance in US-South region. The region can also be modified via the variables.tf.

This example also requires that you provide the SSH Key as a variable. It associates the ssh key with the VM instance. This module also creates a new scurity group and assigns it to the VM instance with the SSH port 22 open so you can connect. This module assigns a public IP by default but that is also a variable setting you can modify if desired.

## Usage

**See examples folder ./examples/ibm-linux-vpc-multidisk**

* <b>Example of main.tf</b>

Required Variables:
* <b>region</b> = name of the IBM Cloud region you want to use
* <b>name</b> = (This is the VM name, and it will also be used in the name of the Security Group that gets created)
* <b>resource_group_id</b> = This is the unique ID of the IBM cloud resource group that you want to use.
* <b>vpc_id</b> = The unique ID of the VPC that you want to use.
* <b>subnet_id</b> = The unique ID of the subnet that you want to use.
* <b>ssh_key_ids</b> = List of the unique SSH Key ID's that you want to add to the instance once it is created.  Seperate ID's with commas to add more than one to the Instance.

<b>Example of variables.tf</b>
* Enter the region you want to use here
```hcl
variable "region" {
  type        = string
  description = "The region where the resources will be created."
  default     = "us-south"
}
```
In this example you will have provide the following variables to pass to the module.

Required Variables:
* <b>name</b>              = The name you want to give the instance you are creating<br>
* <b>profile_name</b>      = "cx2-2x4" The Latest Intel Xeon processor available for the Instance Profile<br> 
* <b>resource_group_id</b> = Your existing Resource Group ID<br>
* <b>vpc_id</b>            = Your existing VPC ID<br>
* <b>subnet_id</b>         = Your existing Subnet ID<br>
* <b>ssh_key_ids</b>       = Your existing SSH ID (seperate by commas if you have multiple)<br>
* <b>allow_ssh_from</b>    = The IP address you want to add SSH access from via the internet<br>
* <b>image_name</b>        = OS Image ID (eg"ibm-ubuntu-22-04-2-minimal-amd64-1")<br>
* <b>create_volume</b>     = Enter a numerical number of how many additional disks you want to add to the instance<br>
* <b>volume_profile</b>    = Choose the type of volume you want to use (eg. general-purpose)<br>
* <b>capacity</b>          = Enter a number to choose the amount of GB for the additional disk you want to add.<br>

#
Example of how to pass variable :
```hcl
# terraform apply -var="region=us-south" -var="name=name1"
```

Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

Provision Intel Cloud Optimization Module
module "module-example" {
  source = "github.com/intel/terraform-intel-ibm-vm"
}


Run Terraform
test
```hcl
terraform init  
terraform plan
terraform apply

```

Note that this example may create resources. Run `terraform destroy` when you don't need these resources anymore.
Example of how to pass variable :
```hcl
# terraform destroy 
```