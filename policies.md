<p align="center">
  <img src="./images/logo-classicblue-800px.png" alt="Intel Logo" width="250"/>
</p>

# Intel® Cloud Optimization Modules for Terraform  

© Copyright 2023, Intel Corporation

## HashiCorp Sentinel Policies

This file documents the HashiCorp Sentinel policies that apply to this module

## Policy 1

Description: The configured "profile_name" should be Intel Xeon 2nd Generation(code-named Cascade Lake) Scalable processors or Intel Xeon 4th Generation(code-named Saphire Rapids).

Resource type: ibm_is_instance

Parameter: profile_name

Allowed Types :  
- **Balanced Optimized:**
bx2-2x8,bx2d-2x8,bx2-4x16,bx2d-4x16,bx2-8x32,bx2d-8x32,bx2-16x64,bx2d-16x64,bx2-32x128,bx2d-32x128,bx2-48x192,bx2d-48x192,bx2-64x256,bx2d-64x256,bx2-96x384,,bx2d-96x384,bx2-128x512,bx2d-128x512,bx3d-2x10,bx3d-4x20,bx3d-8x40,bx3d-16x80,bx3d-24x120,bx3d-32x160,bx3d-48x240,bx3d-64x320,bx3d-96x480
- **Compute Optimized:**
cx2-2x4,cx2d-2x4,cx2-4x8,cx2d-4x8,cx2-8x16,cx2d-8x16,cx2-16x32,cx2d-16x32,cx2-32x64,cx2d-32x64,cx2-48x96,cx2d-48x96,cx2-64x128,cx2d-64x128,cx2-96x192,cx2d-96x192,cx2-128x256,cx2d-128x256,cx3d-8x20,cx3d-16x40,cx3d-24x60,cx3d-32x80,cx3d-48x120,cx3d-64x160,cx3d-96x240,cx3d-128x320,cx3d-176x440
- **Memory Optimized:**
mx2-2x16,mx2d-2x16,mx2-4x32,mx2d-4x32,mx2-8x64,mx2d-8x64,mx2-16x128,mx2d-16x128,mx2-32x256,mx2d-32x256,mx2-48x384,mx2d-48x384,mx2-64x512,mx2d-64x512,mx2-96x768,mx2d-96x768,mx2-128x1024,mx2d-128x1024,mx3d-8x80,mx3d-16x160,mx3d-24x240,mx3d-32x320,mx3d-48x480,mx3d-64x640,mx3d-96x960,mx3d-128x1280,mx3d-176x1760
- **Storage Optimized:**
ox2-2x16,ox2-4x32,ox2-8x64,ox2-16x128,ox2-32x256,ox2-64x512,ox2-96x768,ox2-128x1024
- **Very High Memory Optimized:**
vx2d-2x28,vx2d-4x56,vx2d-8x112,vx2d-16x224,vx2d-44x616,vx2d-88x1232,vx2d-144x2016,vx2d-176x2464
- **Ultra High Memory Optimized:**
ux2d-2x56,ux2d-4x112,ux2d-8x224,ux2d-16x448,ux2d-36x1008,ux2d-48x1344,ux2d-72x2016,ux2d-100x2800,ux2d-200x5600
- **GPU Optimized:**
gx2-8x64x1v100,gx2-16x128x2v100,gx2-32x256x2v100

## Links
https://cloud.ibm.com/docs/vpc?topic=vpc-profiles&interface=ui