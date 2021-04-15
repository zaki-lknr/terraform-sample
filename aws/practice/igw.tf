resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.practice.id

  tags = {
    Name = "igw-aws-study"
  }
}
