########################
####     Intel      ####
########################

# See policies.md, Intel recommends the 4th Generation Intel® Xeon® Platinum (Saphire Rapids) based instances.  At the time of the creation of the module only the 
# 2nd Generation Intel® Xeon® Platinum (Cascade Lake) instances are available.
#
# The policies.md will be updated when Saphire Rapids instances become available.
#
# Instance Profiles:
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

# This module was created with the assumption that you have some infrastructure in place and you want to automate an Virtual server in an existing account/network.
# Assumptions:
#    VPC Exists in a Region
#    Subnet(s) Exists in the VPC
#    Resource Group Exist in the IBM Cloud Account
#    SSH Key(s) Exist in the Resource Group

module "ibm_is_instance" {
  source            = "../../"
  name              = "vm01"                                        #The name you want to give the instance you are creating
  profile_name      = "cx2-2x4"                                     #Latest Intel Xeon processor available for the Instance Profile
  resource_group_id = "0d2599fc021c4bc19e8a330fd8286dbd"            #Existing RG ID
  vpc_id            = "r006-df129de8-bde1-4cda-932c-32e9cdd2e7c7"   #Existing VPC ID
  subnet_id         = "0717-80ebe088-c5e7-4964-a4b9-ebb6acec6dcc"   #Existing Subnet ID
  ssh_key_ids       = ["r006-7c2c713a-257d-4dcd-8882-7aa5b3f5ad3e"] #Security group inbound SSH CIDR Block (Adjust for your specific IP CIDR or IP that you want SSH access from)
  allow_ssh_from    = "134.134.139.84/32"                           #Security group inbound SSH CIDR Block (Adjust for your specific IP CIDR or IP)
  image_name        = "ibm-ubuntu-22-04-2-minimal-amd64-1"          #OS Image ID
}


