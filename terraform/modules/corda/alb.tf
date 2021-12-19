resource "aws_lb" "corda_alb" {
  name               = "${var.developer}s-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id, aws_security_group.alb_outbound_sg.id]
  subnets            = aws_subnet.corda_alb_public_subnet.*.id

  enable_deletion_protection = false
  
  tags = {
    Name = "${var.developer} Application Load Balancer"
    Owner = var.developer
  }

}

resource "aws_lb_listener" "grafana_listener" {
  load_balancer_arn = aws_lb.corda_alb.arn
  port              = "3000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grafana_tg.arn
  }
}

resource "aws_lb_listener" "kibana_listener" {
  load_balancer_arn = aws_lb.corda_alb.arn
  port              = "5601"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kibana_tg.arn
  }
}


resource "aws_lb_target_group" "grafana_tg" {
  name     = "${var.developer}-grafana"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.corda_vpc.id
  
  health_check {
    path = "/login"
    port = 3000
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"
  }

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
  protocol = "HTTP"
  vpc_id   = aws_vpc.corda_vpc.id
  
  health_check {
    path = "/app/home"
    port = 5601
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"
  }

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