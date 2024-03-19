# This is just an example where you could define specific variables for this example.  This example expects to have a VPC provided as part of the main.tf 
# This example does not build a new vpc or subnet.


variable "region" {
  type        = string
  description = "The region where the resources will be created."
  default     = "us-south"
}
