# ランダムパスワード生成
resource "random_password" "db_password" {
  length  = 16
  # 記号を含めるとRDS側でエラーになることがあるため、今回は英数字のみ
  special = false
}

# SSM Parameter Storeにパスワードを保存する設定
resource "aws_ssm_parameter" "db_password" {
  # この名前でパスワードを取り出します
  name  = "/mynextapp/database/password"
  type  = "SecureString" # 暗号化して保存する設定
  value = random_password.db_password.result
}
