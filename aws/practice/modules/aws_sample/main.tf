resource "aws_vpc" "practice" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-aws-study-example"
  }
}

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

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.practice.id

  tags = {
    Name = "igw-aws-study"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.practice.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table-aws-study"
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.prac_public.id
  route_table_id = aws_route_table.public_route.id
}
