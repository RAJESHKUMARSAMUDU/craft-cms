resource "aws_lb_target_group" "craftcms_tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name                  = "craftcms-tg"
  port                  = 80
  protocol              = "HTTP"
  target_type           = "ip"
  vpc_id                = aws_vpc.craftcms-vpc.id
}

resource "aws_lb" "craftcms-alb" {
  name               = "craftcms-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.craftcms.id]
  subnets            = [aws_subnet.public-subnet-1.id,aws_subnet.public-subnet-2.id]
  ip_address_type    = "ipv4"


  tags = {
    Name = "craftcms-alb"
  }
}

resource "aws_lb_listener" "carftcms_alb" {
  load_balancer_arn = aws_lb.craftcms-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.craftcms_tg.arn
  }
}
