resource "aws_subnet" "prac_public" {
  vpc_id            = aws_vpc.practice.id
  cidr_block        = var.prac_public_cidr_block
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "public-subnet-aws-study"
  }
}

resource "aws_subnet" "prac_priv1" {
  vpc_id            = aws_vpc.practice.id
  cidr_block        = var.prac_private1_cidr_block
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "private1-subnet-aws-study"
  }
}

resource "aws_subnet" "prac_priv2" {
  vpc_id            = aws_vpc.practice.id
  cidr_block        = var.prac_private2_cidr_block
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "private2-subnet-aws-study"
  }
}
