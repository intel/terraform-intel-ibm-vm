

<p align="center">
  <img src="./images/logo-classicblue-800px.png" alt="Intel Logo" width="250"/>
</p>

# Intel® Cloud Optimization Modules for Terraform

© Copyright 2022, Intel Corporation

## Module name

## Usage

See examples folder for code ./examples/intel-optimized-postgresql-server/main.tf

Example of main.tf

```hcl
# Example of how to pass variable for database password:
# terraform apply -var="db_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

# Provision Intel Cloud Optimization Module
module "module-example" {
  source = "github.com/intel/module-name"
}

```

Run Terraform

```hcl
terraform init  
terraform plan
terraform apply

```

Note that this example may create resources. Run `terraform destroy` when you don't need these resources anymore.

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
| [ibm_is_instance.instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance) | resource |
| [ibm_is_security_group.security_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group) | resource |
| [ibm_is_security_group_rule.security_group_rule](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_ssh_key.ssh_key](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_ssh_key) | resource |
| [ibm_is_subnet.subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_subnet) | resource |
| [ibm_is_vpc.vpc](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | The name of the image. | `string` | `"r006-c2c24ac1-b03d-4427-85cf-92e95d4aa658"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name of the instance. | `string` | `"wsf-test01-vm"` | no |
| <a name="input_ipv4_cidr_block"></a> [ipv4\_cidr\_block](#input\_ipv4\_cidr\_block) | The CIDR block for the subnet. | `string` | `"10.240.0.0/24"` | no |
| <a name="input_port_max"></a> [port\_max](#input\_port\_max) | The maximum port number for remote access. | `number` | `22` | no |
| <a name="input_port_min"></a> [port\_min](#input\_port\_min) | The minimum port number for remote access. | `number` | `22` | no |
| <a name="input_profile_name"></a> [profile\_name](#input\_profile\_name) | The name of the profile. | `string` | `"bx2-2x8"` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol for remote access. | `string` | `"tcp"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where the resources will be created. | `string` | `"us-south"` | no |
| <a name="input_remote_ip_prefix"></a> [remote\_ip\_prefix](#input\_remote\_ip\_prefix) | The CIDR block for remote access. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The description of the security group. | `string` | `"Test security group"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The name of the security group. | `string` | `"intel-test01-sg"` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | The name of the SSH key. | `string` | `"wsf-key01"` | no |
| <a name="input_ssh_key_public"></a> [ssh\_key\_public](#input\_ssh\_key\_public) | Public key to use when generating SSH Key | `string` | `"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBzaaVccW+zXSRS6qK9yNvGYTHE2GCkguHWCKI7qzYP2eKp4iusJqK0ScwMtkKctmH/TWktT6p3/K8sunnupcwa4brx1Ua64hKdvTWs1hw/HlxYU5ZSOjbuKJJrRsu117CnjSNyW+NBF3roDMXLE7ygvFNOx+UaDdZifwGIA7EYu/Afo3vVjb4EETW0l+KDVE0XWRdkc7eK6J3RqSEzVaNgqdQDYHqaveFQg6LiCQ/Xc8+OpXjVbJT7SirdwdSCpRPfSJhVpp9lkKa/gqKjWUtWUzZbLBBt2M0T4PgsdC7gmhPlB6j95EVxTGGNQgGFZsxAEFe4klJnpz7P/9o6WDB0KeJRndiml6l/Evj+GR0NZA9R5qFVbPR2cJpNSAOX6S6aqssKtHeIF02vHhXT4Hq0ctH5ly/OP0NupkZYgu9A4wY46WRcoMu/U4gB6Q9AQ4AcaxUVRsIOYSZE0p++X3/WsOuNAEFDi39dnKyEnoRL/SJkUFUFd41OhQfLGWyxoU="` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet. | `string` | `"intel-test01-sn"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC. | `string` | `"wsf-vpc"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone where the resources will be created. | `string` | `"us-south-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
<!-- END_TF_DOCS -->