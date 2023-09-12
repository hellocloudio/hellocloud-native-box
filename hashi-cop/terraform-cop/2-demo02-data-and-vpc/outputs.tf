# Output - gritworks-nonprod

output "gritworks_nonprod_vpc_id_output" {
  value = aws_vpc.gritworks_nonprod_vpc.id
}

output "gritworks_nonprod_available_azs_output" {
  value = data.aws_availability_zones.gritworks_nonprod_available_azs
}

# Output - gritworks-dev

output "gritworks_dev_vpc_id_output" {
  value = aws_vpc.gritworks_dev_vpc.id
}

output "gritworks_dev_available_azs_output" {
  value = data.aws_availability_zones.gritworks_dev_available_azs
}

# Output - gritworks-security

output "gritworks_security_vpc_id_output" {
  value = aws_vpc.gritworks_security_vpc.id
}

output "gritworks_security_available_azs_output" {
  value = data.aws_availability_zones.gritworks_security_available_azs
}