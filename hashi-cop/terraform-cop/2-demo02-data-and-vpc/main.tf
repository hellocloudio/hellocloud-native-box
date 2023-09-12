# create vpc - for gritworks-nonprod
resource "aws_vpc" "gritworks_nonprod_vpc" {
  provider = aws.gritworks-nonprod
  cidr_block              = var.gritworks_nonprod_vpc_cidr
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

# create vpc - for gritworks-dev
resource "aws_vpc" "gritworks_dev_vpc" {
  cidr_block              = var.gritworks_dev_vpc_cidr
  provider = aws.gritworks-dev
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

# create vpc - for gritworks-security
resource "aws_vpc" "gritworks_security_vpc" {
  provider = aws.gritworks-security
  cidr_block              = var.gritworks_security_vpc_cidr
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

# use data source to get all avalablility zones in region - gritworks-nonprod
data "aws_availability_zones" "gritworks_nonprod_available_azs" {
  provider = aws.gritworks-nonprod
  state = "available"
}

# use data source to get all avalablility zones in region - gritworks-dev

data "aws_availability_zones" "gritworks_dev_available_azs" {
  provider = aws.gritworks-dev
  state = "available"
}

# use data source to get all avalablility zones in region - gritworks-security

data "aws_availability_zones" "gritworks_security_available_azs" {
  provider = aws.gritworks-security
  state = "available"
}