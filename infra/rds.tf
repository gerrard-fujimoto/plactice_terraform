# RDSインスタンス
resource "aws_db_instance" "app" {
  identifier             = "my-database"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro" # 学習用の最小サイズ
  allocated_storage      = 20            # 最小容量(GB)
  storage_type           = "gp2"

  db_name                = "mynextappdb" # 最初に作られる空のデータベース名
  username               = "admin"       # マスターユーザー名
  
  # ssm.tfで作ったランダムパスワードをセット
  password               = random_password.db_password.result 

  # 配置する場所とセキュリティ
  db_subnet_group_name   = aws_db_subnet_group.app.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # 学習用設定: 削除時にバックアップ(スナップショット)を取らない（trueにしないとdestroy時にエラーになる）
  skip_final_snapshot    = true 
}
