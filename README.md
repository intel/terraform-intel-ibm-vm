

<p align="center">
  <img src="https://github.com/intel/terraform-intel-ibm-vm/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel® Optimized Cloud Modules for Terraform

© Copyright 2024, Intel Corporation

## IBM VPC Compute Instance
This module provides the functionality to ensure that you are utilizing Intel's latest generation processor in the creation of a virtual machine in IBM Cloud in a VPC.

This Optimized Cloud Module leverages Intel's 4th Generation Intel® Xeon® Scalable processors, the Intel 8474C processor (previously code named Sapphire Rapids).  This is IBM's 3rd generation profile labeled with the bx3d, cx3d, andmx3d prefixes.  These are available in the Dallas, London, and Frankfurt regions as of 3/18/2024.  See https://cloud.ibm.com/docs/vpc?topic=vpc-profiles&interface=ui for availability updates.

## Performance Data

#### Find all the information below plus even more by navigating our full library

#


<center>


#### [4th Gen Intel® Xeon® Scalable Processor (Sapphire Rapids)](https://www.intel.com/content/www/us/en/newsroom/news/4th-gen-intel-xeon-outperforms-competition-real-world-workloads.html)


</center>

#

## Usage

See examples folder for code:
* Single Instance created in existing VPC -  ./examples/intel-ibm-linux-vpc
* Single Instances with multiple data disks in existing VPC - ./examples/intel-ibm-linux-vpc-multidisk


#
This module is designed to allow you to provision a virtual machine in an existing IBM cloud account where you have a VPC created.  You will need to provide several variables to specify certain settings.  These settings include:
#
Required Variables:
* <b>region</b> = name of the IBM Cloud region you want to use
* <b>name</b> = (This is the VM name, and it will also be used in the name of the Security Group that gets created)
* <b>profile_name</b> = Instance size and family
* <b>resource_group_id</b> = This is the unique ID of the IBM cloud resource group that you want to use.
* <b>vpc_id</b> = The unique ID of the VPC that you want to use.
* <b>subnet_id</b> = The unique ID of the subnet that you want to use.
* <b>ssh_key_ids</b> = List of the unique SSH Key ID's that you want to add to the instance once it is created.  Seperate ID's with commas to add more than one to the Instance.
* <b>allow_ssh_from</b> = IP Address that you want to allow SSH access to your instance's public ip address.  Security best practices is to not allow 0.0.0.0/0 and specify your ip or range of ip addresses.
* <b>image_name</b> = This will be the OS image that you want to use for your instance.

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
| [ibm_is_security_group_rule.allow_outbound](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.ssh_inbound](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.ssh_to_self_public_ip](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_volume.volumes](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_volume) | resource |
| [ibm_is_image.image](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_image) | data source |
| [ibm_is_subnet.subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tags"></a> [access\_tags](#input\_access\_tags) | A list of access management tags to attach to the instance. | `list(any)` | `[]` | no |
| <a name="input_all_auto_delete_volume"></a> [all\_auto\_delete\_volume](#input\_all\_auto\_delete\_volume) | If set to true, automatically deletes the volumes that are attached to an instance. | `bool` | `null` | no |
| <a name="input_allow_outbound"></a> [allow\_outbound](#input\_allow\_outbound) | An IP address, a CIDR block, or a single security group identifier to allow outbound network connections | `string` | `"0.0.0.0/0"` | no |
| <a name="input_allow_ssh_from"></a> [allow\_ssh\_from](#input\_allow\_ssh\_from) | An IP address, a CIDR block, or a single security group identifier to allow incoming SSH connection to the instance | `string` | `"0.0.0.0/0"` | no |
| <a name="input_availability_policy_host_failure"></a> [availability\_policy\_host\_failure](#input\_availability\_policy\_host\_failure) | The availability policy to use for this virtual server instance. The action to perform if the compute host experiences a failure. Supported values are restart and stop. | `string` | `null` | no |
| <a name="input_boot_volume_auto_delete_volume"></a> [boot\_volume\_auto\_delete\_volume](#input\_boot\_volume\_auto\_delete\_volume) | If set to true, when deleting the instance the volume will also be deleted. | `string` | `null` | no |
| <a name="input_boot_volume_encryption"></a> [boot\_volume\_encryption](#input\_boot\_volume\_encryption) | The type of encryption to use for the boot volume. | `string` | `null` | no |
| <a name="input_boot_volume_size"></a> [boot\_volume\_size](#input\_boot\_volume\_size) | The size of the boot volume.(The capacity of the volume in gigabytes. This defaults to 100gb capacity of the image and maximum to 250. | `number` | `null` | no |
| <a name="input_create_public_ip"></a> [create\_public\_ip](#input\_create\_public\_ip) | Set whether to allocate a public IP address for the instance | `bool` | `true` | no |
| <a name="input_create_volume"></a> [create\_volume](#input\_create\_volume) | If you want to create a volume, change from 0 | `number` | `0` | no |
| <a name="input_dedicated_host"></a> [dedicated\_host](#input\_dedicated\_host) | The placement restrictions to use the virtual server instance. Unique ID of the dedicated host where the instance id placed. | `string` | `null` | no |
| <a name="input_dedicated_host_group"></a> [dedicated\_host\_group](#input\_dedicated\_host\_group) | The placement restrictions to use for the virtual server instance. Unique ID of the dedicated host group where the instance is placed. | `string` | `null` | no |
| <a name="input_existing_volume_ids"></a> [existing\_volume\_ids](#input\_existing\_volume\_ids) | A list of maps describing the volumes for each instance | `list(string)` | `[]` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Name of the OS image to use for the instance | `string` | `"ibm-ubuntu-22-04-2-minimal-amd64-1"` | no |
| <a name="input_init_script"></a> [init\_script](#input\_init\_script) | Script to run during the instance initialization. Defaults to an Ubuntu specific script when set to empty | `string` | `""` | no |
| <a name="input_instance_template"></a> [instance\_template](#input\_instance\_template) | ID of the instance template to create the instance from. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the instance | `string` | `"vm01"` | no |
| <a name="input_placement_group"></a> [placement\_group](#input\_placement\_group) | Unique Identifier of the Placement Group for restricting the placement of the instance. | `string` | `null` | no |
| <a name="input_profile_name"></a> [profile\_name](#input\_profile\_name) | Instance profile for an Intel based Xeon Processor size and family to use for the instance | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where the resources will be created. | `string` | `"us-south"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | ID of the resource group that has the VPC, SSH key, etc. | `string` | n/a | yes |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | List of security group rules to set on the new security group created, in addition to the SSH rules | `list` | <pre>[<br>  {<br>    "direction": "outbound",<br>    "icmp": {<br>      "type": 8<br>    },<br>    "name": "icmp_outbound",<br>    "remote": "0.0.0.0/0"<br>  }<br>]</pre> | no |
| <a name="input_ssh_key_ids"></a> [ssh\_key\_ids](#input\_ssh\_key\_ids) | List of SSH key IDs to inject into the instance.  This is not the public key guid itself, but just the key's IBM ID | `list(string)` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet in the VPC where to create the instance | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags to add on all created resources | `list(string)` | `[]` | no |
| <a name="input_total_volume_bandwidth"></a> [total\_volume\_bandwidth](#input\_total\_volume\_bandwidth) | The amount of bandwidth (in megabits per second) allocated exclusively to instance storage volumes. | `number` | `null` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data to transfer to the instance. | `string` | `null` | no |
| <a name="input_volume_name"></a> [volume\_name](#input\_volume\_name) | Name of the volume to create | `string` | `null` | no |
| <a name="input_volume_profile"></a> [volume\_profile](#input\_volume\_profile) | Profile to use for the volume | `string` | `null` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | n/a | <pre>list(object({<br>    volume_profile = string<br>    capacity       = number<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create the instance | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bandwidth"></a> [bandwidth](#output\_bandwidth) | The total bandwidth (in megabits per second) shared across the instance's network interfaces and storage volumes. |
| <a name="output_boot_volume"></a> [boot\_volume](#output\_boot\_volume) | A list of boot volumes that the instance uses. |
| <a name="output_crn"></a> [crn](#output\_crn) | The CRN of the instance. |
| <a name="output_disks"></a> [disks](#output\_disks) | The collection of the instance's disks. |
| <a name="output_gpu"></a> [gpu](#output\_gpu) | A list of GPUs that are assigned to the instance. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the instance. |
| <a name="output_memory"></a> [memory](#output\_memory) | The amount of memory that is allocated to the instance in gigabytes. |
| <a name="output_name"></a> [name](#output\_name) | The name of the instance. |
| <a name="output_network_interface"></a> [network\_interface](#output\_network\_interface) | The network interface associated with the instance. |
| <a name="output_placement_target"></a> [placement\_target](#output\_placement\_target) | The placement restrictions for the virtual server instance. |
| <a name="output_primary_network_interface"></a> [primary\_network\_interface](#output\_primary\_network\_interface) | A list of primary network interfaces that are attached to the instance. |
| <a name="output_status"></a> [status](#output\_status) | The status of the instance. |
| <a name="output_status_reasons"></a> [status\_reasons](#output\_status\_reasons) | Array of reasons for the current status. |
| <a name="output_total_network_badwidth"></a> [total\_network\_badwidth](#output\_total\_network\_badwidth) | The amount of bandwidth (in megabits per second) allocated exclusively to instance network interfaces. |
| <a name="output_vcpu"></a> [vcpu](#output\_vcpu) | The number of virtual CPUs assigned to the instance. |
| <a name="output_volume_attachments"></a> [volume\_attachments](#output\_volume\_attachments) | A list of volume attachments for the instance. |
<!-- END_TF_DOCS -->