# providers.tf
terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.0"
    }
  }
}





variable "compartment_id" {}

variable "region" {}

data "oci_identity_compartment" "test_compartment" {
  #Required
  id = var.compartment_id
}

provider "oci" {
  auth   = "OKEWorkloadIdentity"
  region = var.region
}

output "tenancy" {
  value = data.oci_identity_compartment.test_compartment
}

