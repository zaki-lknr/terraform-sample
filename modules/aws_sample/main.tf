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


resource "aws_security_group" "allow_ssh_icmp" {
  name        = "ssh-icmp"
  description = "ssh-icmp"
  vpc_id      = aws_vpc.practice.id

  tags = {
    Name = "ssh-icmp-security-group"
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ssh_icmp.id
}

resource "aws_security_group_rule" "icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ssh_icmp.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ssh_icmp.id
}

data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_key_pair" "my_key" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDyK6HCvGQr84FgD+CDa7cCtt+D03bMb2O/surNv5pkSbPJ4T4d+E79tqjqjhxunse5lPnTCKeA22YzCQpjvnfXNci8OeFfHI6Amni8/Y3ANgjJ9W/5MYYXVTrDhohST62zURsZWTSpevK3LAHxzylyzKpKPTUuP204ff7s1G2PEg61w4DEOn19L7MaO0E0aKG6vr5SkvpKCZ9eGW+dhKK6bXW5scmmbmRUquIfO5SvdcCVAS/fbRtuXstIjSJYomhM8eExMVNwl97qC86Fq8jKQbnx1XK/+I/M62sMlJ3/DV0lZGYxAdeBGIP8U2lyH4lfQ2kNGCWaqxnDzKSEqcU8n+lJcmwNXLTj93/gyuqdm5gbAKaTcmftQ30R9LqosrdguNoFy0uN0Mhvo7jqE6a6p5ZRJYi7svAQFslE8OqHKr/ZevoPPFjmWKw8+hgDtJhtxHZO8Rvce0IJI1YILd2hJMDrJQBL0BRaFipGvGd594+DmtdSx2U58KfmaZ0rArLexWa8LjgooRaOdE+54z97wFqgMFgRJz7CgMJAm5dyux4nDFZFpXLWkW4YSyjylCEiEMQtPmi6H+7W4zDx/nrVXFlGxfexNE42ANertD60JzZprnKS9Y6nxqqjow3RqLmqbK8TdtN64/ls+Jsss3FhQDOXNK5WgFKCG1iCuYXCdw=="
}

resource "aws_instance" "bastion" {
  count = var.host_count

  ami                         = data.aws_ssm_parameter.amzn2_ami.value
  instance_type               = "t3.nano"
  key_name                    = aws_key_pair.my_key.id
  subnet_id                   = aws_subnet.prac_public.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh_icmp.id]
  associate_public_ip_address = true

  tags = {
    Name = "bastion-${count.index}"
  }
}

resource "aws_instance" "server" {
  for_each = toset(var.host_list)

  ami                         = data.aws_ssm_parameter.amzn2_ami.value
  instance_type               = "t3.nano"
  key_name                    = aws_key_pair.my_key.id
  subnet_id                   = aws_subnet.prac_priv2.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh_icmp.id]
  associate_public_ip_address = false

  tags = {
    Name = each.value
  }
}
