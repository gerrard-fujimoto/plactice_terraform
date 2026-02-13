# 7. ECSクラスター (ECS Cluster) - 箱だけ作成
resource "aws_ecs_cluster" "main" {
  name = "my-terraform-cluster"
}
