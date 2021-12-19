terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
      
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}



resource "aws_vpc" "build_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  
  tags = {
    Name = "Packer build vpc"
    Class = "build"
  }
}

resource "aws_subnet" "build_public_subnet" {
  vpc_id     = aws_vpc.build_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Packer build subnet"
    Class = "build"
  }
}

resource "aws_internet_gateway" "build_igw" {
  vpc_id = aws_vpc.build_vpc.id

  tags = {
    Name = "Packer build Internet Gateway"
    Class = "build"
  }
}

resource "aws_route_table" "build_pub_rt" {
  vpc_id = aws_vpc.build_vpc.id


}
resource "aws_route" "build_public_ig" {
  route_table_id         = aws_route_table.build_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.build_igw.id

}
resource "aws_route_table_association" "public_build_rt_association" {
  subnet_id      = aws_subnet.build_public_subnet.id
  route_table_id = aws_route_table.build_pub_rt.id

}

