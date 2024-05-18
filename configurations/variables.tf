# Define variables
variable "profile" {
  description = "AWS profile name to use for authentication"
  default     = "default"
}

variable "region" {
  description = "AWS region where resources will be created"
  default     = "af-south-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  default     = "10.0.2.0/23"
}

variable "http_ingress_cidr_block" {
  description = "CIDR block for allowing HTTP ingress traffic"
  default     = "0.0.0.0/0"
}

variable "http_ingress_port" {
  description = "Port for allowing HTTP ingress traffic"
  default     = 80
}