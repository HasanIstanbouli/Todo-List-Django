variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
}
variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "azs" {
  description = "List of Availability Zones to use"
  type        = list(string)
}
variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}
variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}
variable "tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default     = {}
}


