resource "aws_subnet" "corda_public_subnet" {
  vpc_id     = aws_vpc.corda_vpc.id
  cidr_block = var.corda_pub_subnet_cidr
  availability_zone = var.azs_list

  tags = {
    Name = "${var.developer} Corda Public Subnet"
    Owner = var.developer
  }
}


resource "aws_subnet" "corda_private_subnet" {
  vpc_id     = aws_vpc.corda_vpc.id
  cidr_block = var.corda_prv_subnet_cidr
  availability_zone = var.azs_list


  tags = {
    Name = "${var.developer} Corda Private Subnet"
    Owner = var.developer
  }
}

resource "aws_subnet" "corda_nlb_public_subnet" {
  vpc_id     = aws_vpc.corda_vpc.id
  cidr_block = var.corda_nlb_subnet_cidr
  availability_zone = var.azs_list

  tags = {
    Name = "${var.developer} Corda NLB Public Subnet"
    Owner = var.developer
  }
}