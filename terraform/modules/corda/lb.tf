resource "aws_lb" "corda_nlb" {
  name               = "${var.developer}s-nlb"
  internal           = false
  load_balancer_type = "network"

  # subnets            = aws_subnet.corda_nlb_public_subnet.*.id
  subnet_mapping {
    subnet_id     = aws_subnet.corda_nlb_public_subnet.id
    allocation_id = aws_eip.nlb_eip.id
  }

  enable_deletion_protection = false
  
  tags = {
    Name = "${var.developer} NetworkLoad Balancer"
    Owner = var.developer
  }

}

resource "aws_lb_listener" "grafana_listener" {
  load_balancer_arn = aws_lb.corda_nlb.arn
  port              = "3000"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grafana_tg.arn
  }
}

resource "aws_lb_listener" "kibana_listener" {
  load_balancer_arn = aws_lb.corda_nlb.arn
  port              = "5601"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kibana_tg.arn
  }
}


resource "aws_lb_target_group" "grafana_tg" {
  name     = "${var.developer}-grafana"
  port     = 3000
  protocol = "TCP"
  vpc_id   = aws_vpc.corda_vpc.id
  


  tags = {
    Name = "${var.developer} Grafana target group"
    Owner = var.developer
  }
}

resource "aws_lb_target_group_attachment" "grafana_attach" {
  target_group_arn = aws_lb_target_group.grafana_tg.arn
  target_id        = aws_instance.corda_instance.id
  port             = 3000
}

resource "aws_lb_target_group" "kibana_tg" {
  name     = "${var.developer}-kibana"
  port     = 5601
  protocol = "TCP"
  vpc_id   = aws_vpc.corda_vpc.id

  tags = {
    Name = "${var.developer} Kibana target group"
    Owner = var.developer
  }
}

resource "aws_lb_target_group_attachment" "kibana_attach" {
  target_group_arn = aws_lb_target_group.kibana_tg.arn
  target_id        = aws_instance.corda_instance.id
  port             = 5601
}


resource "aws_lb_target_group" "partya_tg" {
  name     = "${var.developer}-partya"
  port     = 10005
  protocol = "TCP"
  vpc_id   = aws_vpc.corda_vpc.id
  


  tags = {
    Name = "${var.developer} PartyA target group"
    Owner = var.developer
  }
}

resource "aws_lb_target_group_attachment" "partya_attach" {
  target_group_arn = aws_lb_target_group.partya_tg.arn
  target_id        = aws_instance.corda_instance.id
  port             = 10005
}

resource "aws_lb_listener" "partya_listener" {
  load_balancer_arn = aws_lb.corda_nlb.arn
  port              = "10005"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.partya_tg.arn
  }
}

resource "aws_lb_target_group" "partyb_tg" {
  name     = "${var.developer}-partyb"
  port     = 10008
  protocol = "TCP"
  vpc_id   = aws_vpc.corda_vpc.id
  


  tags = {
    Name = "${var.developer} PartyB target group"
    Owner = var.developer
  }
}

resource "aws_lb_target_group_attachment" "partyb_attach" {
  target_group_arn = aws_lb_target_group.partyb_tg.arn
  target_id        = aws_instance.corda_instance.id
  port             = 10008
}

resource "aws_lb_listener" "partyb_listener" {
  load_balancer_arn = aws_lb.corda_nlb.arn
  port              = "10008"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.partyb_tg.arn
  }
}