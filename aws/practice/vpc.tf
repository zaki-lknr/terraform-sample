resource "aws_vpc" "practice" {
  cidr_block = "172.26.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-aws-study-example"
  }
}
