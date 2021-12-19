resource "aws_subnet" "corda_public_subnet" {
  vpc_id     = aws_vpc.corda_vpc.id
  cidr_block = var.corda_pub_subnet_cidr
  availability_zone = var.instance_az

  tags = {
    Name = "${var.developer} Corda Public Subnet"
    Owner = var.developer
  }
}


resource "aws_subnet" "corda_private_subnet" {
  vpc_id     = aws_vpc.corda_vpc.id
  cidr_block = var.corda_prv_subnet_cidr
  availability_zone = var.instance_az


  tags = {
    Name = "${var.developer} Corda Private Subnet"
    Owner = var.developer
  }
}

resource "aws_subnet" "corda_alb_public_subnet" {
  vpc_id     = aws_vpc.corda_vpc.id
  cidr_block = "${element(var.corda_alb_subnet_cidr, count.index)}"
  availability_zone = "${element(var.azs_list, count.index)}"
  count = 3

  tags = {
    Name = "${var.developer} Corda Alb Public Subnet"
    Owner = var.developer
  }
}