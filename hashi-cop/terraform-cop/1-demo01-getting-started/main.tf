# Data Source - gritworks-nonprod

data "aws_caller_identity" "gritworks_nonprod_calleridentity" {
  provider = aws.gritworks-nonprod
}

data "aws_vpc" "gritworks_nonprod_vpcc" {
  provider = aws.gritworks-nonprod
  default = "true" 
}

data "aws_availability_zones" "gritworks_nonprod_azs" {
  provider = aws.gritworks-nonprod
}

# Data Source - gritworks-dev

data "aws_caller_identity" "gritworks_dev_calleridentity" {
  provider = aws.gritworks-dev
}

data "aws_vpc" "gritworks_dev_vpcc" {
  provider = aws.gritworks-dev
  default = "true"
}

data "aws_availability_zones" "gritworks_dev_azs" {
  provider = aws.gritworks-dev
}

# Data Source - gritworks-security

data "aws_caller_identity" "gritworks_security_calleridentity" {
  provider = aws.gritworks-security
}

data "aws_vpc" "gritworks_security_vpcc" {
  provider = aws.gritworks-security
  default = "true"
}

data "aws_availability_zones" "gritworks_security_azs" {
  provider = aws.gritworks-security
}