

resource "aws_route_table" "corda_pub_rt" {
  vpc_id = aws_vpc.corda_vpc.id
  tags = {
    Name = "${var.developer} Corda Public RT"
    Owner = var.developer
  }

}
resource "aws_route" "corda_public_ig" {
  route_table_id         = aws_route_table.corda_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.corda_igw.id

}
resource "aws_route_table_association" "public_corda_rt_association" {
  subnet_id      = aws_subnet.corda_public_subnet.id
  route_table_id = aws_route_table.corda_pub_rt.id

}

resource "aws_route_table" "corda_prv_rt" {
  vpc_id = aws_vpc.corda_vpc.id
  tags = {
    Name = "${var.developer} Corda Private RT"
    Owner = var.developer
  }

}
resource "aws_route" "corda_route" {
  route_table_id         = aws_route_table.corda_prv_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.corda_nat_gateway.id
}

resource "aws_route_table_association" "private_corda_rt_association" {
  subnet_id      = aws_subnet.corda_private_subnet.id
  route_table_id = aws_route_table.corda_prv_rt.id
}

resource "aws_route_table" "corda_nlb_pub_rt" {
  vpc_id = aws_vpc.corda_vpc.id


  tags = {
    Name = "${var.developer} Corda NLB Public RT"
    Owner = var.developer
  }

}
resource "aws_route" "nlb_public_ig" {
  route_table_id         = "${aws_route_table.corda_nlb_pub_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.corda_igw.id}"

}
resource "aws_route_table_association" "nlb_rt_association" {
  subnet_id      = aws_subnet.corda_nlb_public_subnet.id
  route_table_id = aws_route_table.corda_nlb_pub_rt.id

}
