# 1. プロバイダー設定（AWSを使う宣言）
provider "aws" {
  region = "ap-northeast-1" # 東京リージョン
}

# 2. ネットワークの土台 (VPC)
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-test-vpc"
  }
}

# 3. インターネットゲートウェイ (IGW)
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-lesson-igw"
  }
}

# 4. サブネット (Subnet)
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  # これをtrueにすると、ここに作られたサーバーに自動でパブリックIPがつく
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-lesson-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "terraform-lesson-private-subnet"
  }
}

# 5. ルートテーブル (Route Table)
# Public用ルートテーブル
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  # 外の世界(0.0.0.0/0)への行き先案内
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "terraform-lesson-public-rt"
  }
}

# 6. ルートテーブルの紐付け (Association)
# 「Public Subnet」に「Public用ルートテーブル」を設置する
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  
  route_table_id = aws_route_table.public.id
}

# 7. ECSクラスター (ECS Cluster) - 箱だけ作成
resource "aws_ecs_cluster" "main" {
  name = "my-terraform-cluster"
}
