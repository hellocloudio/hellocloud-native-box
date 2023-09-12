terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.12.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["/home/vagrant/.aws/config"]
  shared_credentials_files = ["/home/vagrant/.aws/credentials"]
  profile                  = "gritworks-nonprod"
  alias                    = "gritworks-nonprod"
  region                   = var.gritworks_nonprod_aws_region
}

provider "aws" {
  shared_config_files      = ["/home/vagrant/.aws/config"]
  shared_credentials_files = ["/home/vagrant/.aws/credentials"]
  profile                  = "gritworks-dev"
  alias                    = "gritworks-dev"
  region                   = var.gritworks_dev_aws_region
}

provider "aws" {
  shared_config_files      = ["/home/vagrant/.aws/config"]
  shared_credentials_files = ["/home/vagrant/.aws/credentials"]
  profile                  = "gritworks-security"
  alias                    = "gritworks-security"
  region                   = var.gritworks_security_aws_region
}