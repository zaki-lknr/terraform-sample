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
  security_groups             = [aws_security_group.allow_ssh_icmp.id]
  associate_public_ip_address = true

  tags = {
    Name = "bastion-${count.index}"
  }
}
