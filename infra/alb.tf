resource "aws_lb" "app" {
  name               = "prctice-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_public.id]
  subnets = [
    aws_subnet.public_1a.id,
    aws_subnet.public_1c.id
  ]
}

resource "aws_lb_target_group" "app" {
  name        = "my-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.app.id
  target_type = "ip"
  health_check {
    path = "/"
    port = 3000
  }
}

resource "aws_lb_listener" "http_80" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
