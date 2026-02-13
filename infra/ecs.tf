# 7. ECSクラスター (ECS Cluster) 
resource "aws_ecs_cluster" "app" {
  name = "my-terraform-cluster"
}

# タスク定義
resource "aws_ecs_task_definition" "app" {
  family                   = "my-nextjs-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name         = "nextjs-container"
    image        = "849276620008.dkr.ecr.ap-northeast-1.amazonaws.com/nextjs-sample-app:latest"
    portMappings = [{ containerPort = 3000, hostPort = 3000 }]
  }])
}

# ECSサービス
resource "aws_ecs_service" "app" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_1a.id]
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "nextjs-container"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.http_80]
}
