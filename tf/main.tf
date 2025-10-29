# providers.tf
terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
  backend "oci" {
    bucket    = "wi_terraform"
    namespace = "idjuatm1d4mr"
    region    = "eu-frankfurt-1"
    key       = "terraform.tfstate"
    auth      = "OKEWorkloadIdentity"
  }
}




variable "compartment_id" {}

variable "region" {}

data "oci_identity_compartment" "test_compartment" {
  #Required
  id = var.compartment_id
}



# module "vcn" {
#   source  = "oracle-terraform-modules/vcn/oci"
#   version = "2.2.0"

#   compartment_id = var.compartment_id

#   # vcn parameters
#   create_drg               = false
#   internet_gateway_enabled = true
#   lockdown_default_seclist = true
#   nat_gateway_enabled      = false
#   service_gateway_enabled  = false
#   vcn_cidr                 = "10.0.0.0/16"
#   vcn_dns_label            = "wivcn"
#   vcn_name                 = "wivcn"
# }

provider "oci" {
  auth   = "OKEWorkloadIdentity"
  region = var.region
}

output "tenancy" {
  value = data.oci_identity_compartment.test_compartment
}

