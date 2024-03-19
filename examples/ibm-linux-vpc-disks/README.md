<p align="center">
  <img src="https://github.com/intel/terraform-intel-ibm-vm/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel Optimized Cloud Modules for Terraform

© Copyright 2024, Intel Corporation

## Terraform Intel IBM VM - Linux VM in VPC

This example creates an IBM virtual instance on Intel's 4th Generation Intel® Xeon® Scalable processor on Linux Operating System in a VPC you specify. The VPC id has to be passed in this module as a variable. It is configured to create the VM instance in US-South region. The region can also be modified via the variables.tf.


This example also requires that you provide the SSH Key as a variable. It associates the ssh key with the VM instance. This module also creates a new scurity group and assigns it to the VM instance with the SSH port 22 open so you can connect. This module assigns a public IP by default but that is also a variable setting you can modify if desired.

## Usage

**See examples folder ./examples/ibm-linux-vpc-disks**

* <b>Example of main.tf</b>

Required Variables:
* <b>name</b> = (This is the VM name, and it will also be used in the name of the Security Group that gets created)
* <b>profile_name</b> = Instance size and family
* <b>resource_group_id</b> = This is the unique ID of the IBM cloud resource group that you want to use.  You can find the ID through the IBM Cloud UI under "Manage-Account".  Resource groups ID will look something like this: "0d2588fc021c4bc44e8a330ab8286dbd"
* <b>vpc_id</b> = The unique ID of the VPC that you want to use.  You can find this under the Network-VPC menu in the UI.  The VPC ID is available from the Overview section of the VPC properties.
* <b>subnet_id</b> = The unique ID of the subnet that you want to use.  This is also available under the Network-VPC menu.  At the bottom of the VPC you will see a list of the Subnets available in the VPC.  Click on one of the subnets you want to deploy in and the Subnet ID will be listed in the overview
* <b>ssh_key_ids</b> = List of the unique SSH Key ID's that you want to add to the instance once it is created.  Seperate ID's with commas to add more than one to the Instance.  SSH keys are found under the compute menu in the UI.  SSH Keys are also required to be in the same resource group as the VPC and the VM you are wanting to create.
* <b>allow_ssh_from</b> = IP Address that you want to allow SSH access to your instance's public ip address.  Security best practices is to not allow 0.0.0.0/0 and specify your ip or range of ip addresses.
* <b>image_name</b> = This will be the OS image that you want to use for your instance.

<b>Example of variables.tf</b>
Currently the variables.tf file is not used as deployment of this example requires an existing VPC which will already be in a region.  This file is just an example for if you wanted to add custom variables they would go here.

```hcl
variable "region" {
  type        = string
  description = "The region where the resources will be created."
  default     = "us-south"
}
```

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
# terraform destroy -var="region=us-south" -var="name=name1"
```