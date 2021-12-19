resource "aws_security_group" "bastion_sg" {
  description = "Security group for Bastion server"
  name        = "${var.developer}s Bastion Security Group"
  vpc_id      = aws_vpc.corda_vpc.id

  tags = {
    Name = "${var.developer} Bastion SG"
    Owner = var.developer
  }

  ingress {
    description = "bastion_inbound_ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


    egress {
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = [var.corda_prv_subnet_cidr] 
  }
}

resource "aws_security_group" "corda_sg" {
  description = "${var.developer}s Corda sg"
  name        = "${var.developer}s Corda sg"
  vpc_id      = aws_vpc.corda_vpc.id

  tags = {
    Name = "${var.developer} Corda Security Group"
    Owner = var.developer
  }

  egress {
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  ingress {
    from_port         = 3000
    to_port           = 3000
    protocol          = "tcp"
    cidr_blocks       = var.whitelist
  }

  ingress {
    from_port         = 5601
    to_port           = 5601
    protocol          = "tcp"
    cidr_blocks       = var.whitelist
  }

  ingress {
    from_port         = 10005
    to_port           = 10005
    protocol          = "tcp"
    cidr_blocks       = var.whitelist
  }

  ingress {
    from_port         = 10008
    to_port           = 10008
    protocol          = "tcp"
    cidr_blocks       = var.whitelist
  }
  ingress {
    from_port         = 3000
    to_port           = 3000
    protocol          = "tcp"
    cidr_blocks       = ["${aws_eip.nlb_eip.public_ip}/32"]
  }

  ingress {
    from_port         = 5601
    to_port           = 5601
    protocol          = "tcp"
    cidr_blocks       = ["${aws_eip.nlb_eip.public_ip}/32"]
  }

  ingress {
    from_port         = 10005
    to_port           = 10005
    protocol          = "tcp"
    cidr_blocks       = ["${aws_eip.nlb_eip.public_ip}/32"]
  }

  ingress {
    from_port         = 10008
    to_port           = 10008
    protocol          = "tcp"
    cidr_blocks       = ["${aws_eip.nlb_eip.public_ip}/32"]
  }

  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    security_groups   = [aws_security_group.bastion_sg.id] 
  }

  depends_on = [
    aws_eip.nlb_eip
  ]
}
