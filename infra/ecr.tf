resource "aws_ecr_repository" "app" {
  name                 = "nextjs-sample-app"
  image_tag_mutability = "MUTABLE"

  # 学習用設定: destroyした時に中の画像ごと強制削除する（これがないとエラーで消せなくなる）
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

# 作られたリポジトリのURLを表示する（アップロード時に使うため）
output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}
