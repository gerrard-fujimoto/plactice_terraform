moved {
  from = aws_vpc.main
  to   = aws_vpc.app
}

moved {
  from = aws_internet_gateway.main
  to   = aws_internet_gateway.app
}

moved {
  from = aws_security_group.alb
  to   = aws_security_group.alb_public
}

moved {
  from = aws_security_group.ecs
  to   = aws_security_group.ecs_service
}

moved {
  from = aws_lb.main
  to   = aws_lb.app
}

moved {
  from = aws_lb_target_group.main
  to   = aws_lb_target_group.app
}

moved {
  from = aws_lb_listener.http
  to   = aws_lb_listener.http_80
}

moved {
  from = aws_ecs_cluster.main
  to   = aws_ecs_cluster.app
}

moved {
  from = aws_ecs_task_definition.main
  to   = aws_ecs_task_definition.app
}

moved {
  from = aws_ecs_service.main
  to   = aws_ecs_service.app
}

moved {
  from = aws_ecr_repository.main
  to   = aws_ecr_repository.app
}
