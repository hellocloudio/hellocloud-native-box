variable "gritworks_nonprod_aws_region" {
  description = "AWS region to deploy resources into"
  type = string
  default = "ap-southeast-1"
}

variable "gritworks_dev_aws_region" {
  description = "AWS region to deploy resources into"
  type = string
  default = "ap-southeast-1"
}

variable "gritworks_security_aws_region" {
  description = "AWS region to deploy resources into"
  type = string
  default = "ap-southeast-1"
}

variable "gritworks_nonprod_vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "gritworks_dev_vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
  default = "172.16.0.0/16"
}

variable "gritworks_security_vpc_cidr" {
  description = "CIDR block for VPC"
  type = string
  default = "192.168.0.0/16"
}

variable "project_name" {
  description = "Project Name"
  type = string
  default = "hellocloud"
}