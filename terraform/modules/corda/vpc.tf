resource "aws_vpc" "corda_vpc" {
  cidr_block = var.corda_vpc_cidr
  enable_dns_hostnames = "true"
  
  tags = {
    Name = "${var.developer} Corda VPC"
    Owner = var.developer
  }
}

