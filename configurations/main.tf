#1 Provider Block
provider "aws" {
  profile = var.profile
  region  = var.region
}

#2 Set up a Private Virtual Private Network (VPC)
resource "aws_vpc" "thato_vpc" {
  cidr_block = var.vpc_cidr_block
  tags       = {
    Name = "ThatoVPC"
  }
}

#3 Create a public subnet
resource "aws_subnet" "thato_public_subnet" {
  vpc_id     = aws_vpc.thato_vpc.id
  cidr_block = var.public_subnet_cidr_block
  tags       = {
    Name = "ThatoPublicSubnet"
  }
}

#4 Create a private subnet
resource "aws_subnet" "thato_private_subnet" {
  vpc_id     = aws_vpc.thato_vpc.id
  cidr_block = var.private_subnet_cidr_block
  tags       = {
    Name = "ThatoPrivateSubnet"
  }
}

#5 Create Internet Gateway for public subnet
resource "aws_internet_gateway" "thato_igw" {
  vpc_id = aws_vpc.thato_vpc.id
  tags   = {
    Name = "ThatoIGW"
  }
}

#6 Create a route table for public subnet
resource "aws_route_table" "thato_public_rt" {
  vpc_id = aws_vpc.thato_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.thato_igw.id
  }

  tags   = {
    Name = "ThatoRouteTable"
  }
}

#7 Create route table association with public subnet
resource "aws_route_table_association" "thato_rt_association" {
  subnet_id      = aws_subnet.thato_public_subnet.id
  route_table_id = aws_route_table.thato_public_rt.id
}

#8 Create Security Group for public subnet
resource "aws_security_group" "thato_public_sg" {
  vpc_id = aws_vpc.thato_vpc.id
  name   = "ThatoPublicSG"

  # Define ingress rules (incoming traffic)
  ingress {
    from_port   = var.http_ingress_port
    to_port     = var.http_ingress_port
    protocol    = "tcp"
    cidr_blocks = [var.http_ingress_cidr_block] # Allow incoming HTTP traffic from anywhere
  }

  # Define egress rules (outgoing traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ThatoPublicSG"
  }
}
