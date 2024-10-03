resource "aws_vpc" "practice" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-aws-study-example"
  }
}
