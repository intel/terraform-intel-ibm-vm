# Provision an IBM Linux VM Instance using an Intel 4th Generation Xeon Processor (Saphire Rapids) . It is configured to create the VM instance in the n
# us-south region. The region is provided in variables.tf in this example folder.

# This module was created with the assumption that you have some infrastructure in place and you want to automate an Virtual server in an existing account/network.
# Assumptions:
#    VPC Exists in a Region
#    Subnet(s) Exists in the VPC
#    Resource Group Exist in the IBM Cloud Account
#    SSH Key(s) Exist in the Resource Group

module "ibm_is_instance" {
  source            = "../../"
  name              = "vm01"
  profile_name      = "bx2-2x8"
  resource_group_id = "0d2599fc021c4bc19e8a330fd8286dbd"
  vpc_id            = "r006-df129de8-bde1-4cda-932c-32e9cdd2e7c7"
  subnet_id         = "0717-80ebe088-c5e7-4964-a4b9-ebb6acec6dcc"
  ssh_key_ids       = ["r006-7c2c713a-257d-4dcd-8882-7aa5b3f5ad3e"]
  allow_ssh_from = "0.0.0.0/0"
}


