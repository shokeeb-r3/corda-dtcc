resource "aws_internet_gateway" "corda_igw" {
  vpc_id = aws_vpc.corda_vpc.id

  tags = {
    Name = "${var.developer} Corda Internet Gateway"
    Owner = var.developer
  }
}

resource "aws_nat_gateway" "corda_nat_gateway" {
  allocation_id = aws_eip.corda_eip.id
  subnet_id     = aws_subnet.corda_public_subnet.id
  tags = {
    Name = "${var.developer} Corda NAT Gateway"
    Owner = var.developer
  }
}

resource "aws_eip" "corda_eip" {
  vpc = true

  tags = {
    Name = "${var.developer} Corda EIP"
    Owner = var.developer
  }
}


