terraform {
  required_version = ">=1.3.0"
  required_providers {
    ibm = {
      source  = "IBM-cloud/ibm"
      version = "~> 1.53.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.4.3"
    }
  }
}