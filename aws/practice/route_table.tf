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
