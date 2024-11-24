<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.my_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route_table.public_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.allow_ssh_icmp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.icmp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.prac_priv1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.prac_priv2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.prac_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.practice](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_ssm_parameter.amzn2_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_host_count"></a> [host\_count](#input\_host\_count) | host count | `number` | `3` | no |
| <a name="input_host_list"></a> [host\_list](#input\_host\_list) | host count | `list(string)` | <pre>[<br/>  "app",<br/>  "db"<br/>]</pre> | no |
| <a name="input_prac_private1_cidr_block"></a> [prac\_private1\_cidr\_block](#input\_prac\_private1\_cidr\_block) | CIDR Block of Private1 Subnet | `string` | `"172.26.20.0/24"` | no |
| <a name="input_prac_private2_cidr_block"></a> [prac\_private2\_cidr\_block](#input\_prac\_private2\_cidr\_block) | CIDR Block of Private2 Subnet | `string` | `"172.26.30.0/24"` | no |
| <a name="input_prac_public_cidr_block"></a> [prac\_public\_cidr\_block](#input\_prac\_public\_cidr\_block) | CIDR Block of Public Subnet | `string` | `"172.26.10.0/24"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR Block of VPC | `string` | `"172.26.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->