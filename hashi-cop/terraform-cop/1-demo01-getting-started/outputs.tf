# Output - gritworks-nonprod

output "gritworks-nonprod-calleridentity-info" {
  value = data.aws_caller_identity.gritworks-nonprod-calleridentity
}

output "gritworks-nonprod-vpc-info" {
  value = data.aws_vpc.gritworks-nonprod-vpc
}

output "gritworks-nonprod-azs-info" {
  value = data.aws_availability_zones.gritworks-nonprod-azs
}

# Output - gritworks-dev

output "gritworks-dev-calleridentity-info" {
  value = data.aws_caller_identity.gritworks-dev-calleridentity
}

output "gritworks-dev-vpc-info" {
  value = data.aws_vpc.gritworks-dev-vpc
}

output "gritworks-dev-azs-info" {
  value = data.aws_availability_zones.gritworks-dev-azs
}

# Output - gritworks-security

output "gritworks-security-calleridentity-info" {
  value = data.aws_caller_identity.gritworks-security-calleridentity
}

output "gritworks-security-vpc-info" {
  value = data.aws_vpc.gritworks-security-vpc
}

output "gritworks-security-azs-info" {
  value = data.aws_availability_zones.gritworks-security-azs
}