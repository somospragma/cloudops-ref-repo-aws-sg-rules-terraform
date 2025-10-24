###########################################
############# AWS Provider ################
###########################################
provider "aws" {
  alias   = "principal"
  region  = var.aws_region
  profile = var.profile

  default_tags {
    tags = var.common_tags
  }
}
###########################################
# Version definition - Terraform - Providers
###########################################
terraform {
  required_version = ">= 1.13.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }
  }
}