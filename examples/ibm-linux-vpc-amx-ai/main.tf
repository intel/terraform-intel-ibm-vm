########################
####     Intel      ####
########################

# See policies.md, Intel recommends the 4th Generation Intel® Xeon® Platinum (Saphire Rapids) based instances.  
#
# Allowed Types :  
# - **Balanced Optimized:**
# bx2-2x8,bx2d-2x8,bx2-4x16,bx2d-4x16,bx2-8x32,bx2d-8x32,bx2-16x64,bx2d-16x64,bx2-32x128,bx2d-32x128,bx2-48x192,bx2d-48x192,bx2-64x256,bx2d-64x256,bx2-96x384,,bx2d-96x384,bx2-128x512,bx2d-128x512,bx3d-2x10,bx3d-4x20,bx3d-8x40,bx3d-16x80,bx3d-24x120,bx3d-32x160,bx3d-48x240,bx3d-64x320,bx3d-96x480
# - **Compute Optimized:**
# cx2-2x4,cx2d-2x4,cx2-4x8,cx2d-4x8,cx2-8x16,cx2d-8x16,cx2-16x32,cx2d-16x32,cx2-32x64,cx2d-32x64,cx2-48x96,cx2d-48x96,cx2-64x128,cx2d-64x128,cx2-96x192,cx2d-96x192,cx2-128x256,cx2d-128x256,cx3d-8x20,cx3d-16x40,cx3d-24x60,cx3d-32x80,cx3d-48x120,cx3d-64x160,cx3d-96x240,cx3d-128x320,cx3d-176x440
# - **Memory Optimized:**
# mx2-2x16,mx2d-2x16,mx2-4x32,mx2d-4x32,mx2-8x64,mx2d-8x64,mx2-16x128,mx2d-16x128,mx2-32x256,mx2d-32x256,mx2-48x384,mx2d-48x384,mx2-64x512,mx2d-64x512,mx2-96x768,mx2d-96x768,mx2-128x1024,mx2d-128x1024,mx3d-8x80,mx3d-16x160,mx3d-24x240,mx3d-32x320,mx3d-48x480,mx3d-64x640,mx3d-96x960,mx3d-128x1280,mx3d-176x1760
# - **Storage Optimized:**
# ox2-2x16,ox2-4x32,ox2-8x64,ox2-16x128,ox2-32x256,ox2-64x512,ox2-96x768,ox2-128x1024
# - **Very High Memory Optimized:**
# vx2d-2x28,vx2d-4x56,vx2d-8x112,vx2d-16x224,vx2d-44x616,vx2d-88x1232,vx2d-144x2016,vx2d-176x2464
# - **Ultra High Memory Optimized:**
# ux2d-2x56,ux2d-4x112,ux2d-8x224,ux2d-16x448,ux2d-36x1008,ux2d-48x1344,ux2d-72x2016,ux2d-100x2800,ux2d-200x5600
# - **GPU Optimized:**
# gx2-8x64x1v100,gx2-16x128x2v100,gx2-32x256x2v100

## Links
#https://cloud.ibm.com/docs/vpc?topic=vpc-profiles&interface=ui

########################

data "cloudinit_config" "ansible" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud_init"
    content_type = "text/cloud-config"
    content = templatefile(
      "cloud_init.yml",
      {}
    )
  }
}

# This module was created with the assumption that you have some infrastructure in place and you want to automate an Virtual server in an existing account/network.
# Assumptions:
#    Check the provider.tf to make sure your IBM API Key for your Cloud Subscription is passed correctly
#    VPC Exists in a Region
#    Subnet(s) Exists in the VPC
#    Resource Group Exist in the IBM Cloud Account
#    SSH Key(s) Exist in the Resource Group

module "ibm_is_instance" {
  source            = "intel/ibm-vm/intel"
  name              = "gen-ai-demo-vm"                                           #The name you want to give the instance you are creating
  resource_group_id = "<YOUR RESOURCE GROUP ID HERE>"                            #Existing RG ID: Example "0d2588fd021c4ac19e8a220fe8245dbd"
  vpc_id            = "<YOUR VPC ID HERE>"                                       #Existing VPC ID: Example "r006-df145de5-bdg1-4add-933c-32e6ces2e7c7"
  subnet_id         = "<YOUR SUBNET ID HERE>"                                    #Existing Subnet ID: Example "0227-4c477cag-b7w7-4243-a38c-dd33e2e3c803"
  ssh_key_ids       = ["<YOUR SSH KEY ID HERE>"]                                 #SSH Key ID that you created: Example "r006-1b2bfdde-cb3a-457f-b9e9-08774d049b42"
  image_name        = "ibm-ubuntu-22-04-2-minimal-amd64-1"                       #OS Image ID
  user_data         = data.cloudinit_config.ansible.rendered                     # Intel OCR callled here
  profile_name      = "bx3d-24x120"
  security_group_rules = [   
    {
        name      = "tcp_inbound1"
        direction = "inbound"
        remote    = "0.0.0.0/0"
        tcp = {
        port_min = 7860
        port_max = 7860
        }
    },
    {
        name      = "tcp_inbound2"
        direction = "inbound"
        remote    = "0.0.0.0/0"
        tcp = {
        port_min = 5000
        port_max = 5000
        }
    },
    {
        name      = "tcp_inbound3"
        direction = "inbound"
        remote    = "0.0.0.0/0"
        tcp = {
        port_min = 5001
        port_max = 5001
        }
    },
  
  ]


}