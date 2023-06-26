

<p align="center">
  <img src="https://github.com/intel/terraform-intel-ibm-vm/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel® Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## IBM VPC Compute Instance
This module provides the functionality to ensure that you are utilizing Intel's latest generation processor in the creation of a virtual machine in IBM Cloud in a VPC.

## Performance Data

#### Find all the information below plus even more by navigating our full library

#


<center>

#### [4th Gen Intel® Xeon® Scalable Processor (Sapphire Rapids)](https://www.intel.com/content/www/us/en/newsroom/news/4th-gen-intel-xeon-outperforms-competition-real-world-workloads.html)


</center>

#

## Usage

See examples folder for code ./examples/intel-ibm-linux-vpc

Example of main.tf
#
This module is designed to allow you to provision a virtual machine in an existing IBM cloud account where you have a VPC created.  You will need to provide several variables to specify certain settings.  These settings include:
#
Required Variables:
* <b>region</b> = name of the IBM Cloud region you want to use
* <b>name</b> = (This is the VM name, and it will also be used in the name of the Security Group that gets created)
* <b>resource_group_id</b> = This is the unique ID of the IBM cloud resource group that you want to use.
* <b>vpc_id</b> = The unique ID of the VPC that you want to use.
* <b>subnet_id</b> = The unique ID of the subnet that you want to use.
* <b>ssh_key_ids</b> = List of the unique SSH Key ID's that you want to add to the instance once it is created.  Seperate ID's with commas to add more than one to the Instance.
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

## Considerations  
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | ~> 1.53.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | ~> 1.53.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_floating_ip.vpcinstance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_floating_ip) | resource |
| [ibm_is_instance.vpcinstance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance) | resource |
| [ibm_is_security_group.vpcinstance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group) | resource |
| [ibm_is_security_group_rule.additional_all_rules](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.additional_icmp_rules](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.additional_tcp_rules](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.additional_udp_rules](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.ssh_inbound](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.ssh_to_self_public_ip](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_image.image](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_image) | data source |
| [ibm_is_subnet.subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_ssh_from"></a> [allow\_ssh\_from](#input\_allow\_ssh\_from) | An IP address, a CIDR block, or a single security group identifier to allow incoming SSH connection to the instance | `string` | `"0.0.0.0/0"` | no |
| <a name="input_create_public_ip"></a> [create\_public\_ip](#input\_create\_public\_ip) | Set whether to allocate a public IP address for the instance | `bool` | `true` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Name of the OS image to use for the instance | `string` | `"ibm-ubuntu-22-04-2-minimal-amd64-1"` | no |
| <a name="input_init_script"></a> [init\_script](#input\_init\_script) | Script to run during the instance initialization. Defaults to an Ubuntu specific script when set to empty | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the instance | `string` | `"vm01"` | no |
| <a name="input_profile_name"></a> [profile\_name](#input\_profile\_name) | Instance profile for an Intel based Xeon Process to use for the instance | `string` | `"bx2-2x8"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where the resources will be created. | `string` | `"us-south"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | ID of the resource group that has the VPC, SSH key, etc. | `string` | `"0d2599fc021c4bc19e8a330fd8286dbd"` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | List of security group rules to set on the new security group created, in addition to the SSH rules | `list` | <pre>[<br>  {<br>    "direction": "outbound",<br>    "name": "http_outbound",<br>    "remote": "0.0.0.0/0",<br>    "tcp": {<br>      "port_max": 80,<br>      "port_min": 80<br>    }<br>  },<br>  {<br>    "direction": "outbound",<br>    "name": "https_outbound",<br>    "remote": "0.0.0.0/0",<br>    "tcp": {<br>      "port_max": 443,<br>      "port_min": 443<br>    }<br>  },<br>  {<br>    "direction": "outbound",<br>    "name": "dns_outbound",<br>    "remote": "0.0.0.0/0",<br>    "udp": {<br>      "port_max": 53,<br>      "port_min": 53<br>    }<br>  },<br>  {<br>    "direction": "outbound",<br>    "icmp": {<br>      "type": 8<br>    },<br>    "name": "icmp_outbound",<br>    "remote": "0.0.0.0/0"<br>  }<br>]</pre> | no |
| <a name="input_ssh_key_ids"></a> [ssh\_key\_ids](#input\_ssh\_key\_ids) | List of SSH key IDs to inject into the instance.  This is not the public key itself, but just the key's IBM ID | `list(string)` | <pre>[<br>  "r006-7c2c713a-257d-4dcd-8882-7aa5b3f5ad3e"<br>]</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet in the VPC where to create the instance | `string` | `"0717-80ebe088-c5e7-4964-a4b9-ebb6acec6dcc"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags to add on all created resources | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create the instance | `string` | `"r006-df129de8-bde1-4cda-932c-32e9cdd2e7c7"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpcinstance_id"></a> [vpcinstance\_id](#output\_vpcinstance\_id) | ID of the vpcinstance virtual server instance |
| <a name="output_vpcinstance_network_interface_ids"></a> [vpcinstance\_network\_interface\_ids](#output\_vpcinstance\_network\_interface\_ids) | ID of the primary\_network\_interface for the vpcinstance instance |
| <a name="output_vpcinstance_private_ip"></a> [vpcinstance\_private\_ip](#output\_vpcinstance\_private\_ip) | Private IP address of the vpcinstance virtual server instance |
| <a name="output_vpcinstance_public_ip"></a> [vpcinstance\_public\_ip](#output\_vpcinstance\_public\_ip) | Public IP address of the vpcinstance virtual server instance, null if none was allocated. |
| <a name="output_vpcinstance_security_group_id"></a> [vpcinstance\_security\_group\_id](#output\_vpcinstance\_security\_group\_id) | ID of the new security group that gets created and assigned to the vpcinstance interface |
<!-- END_TF_DOCS -->