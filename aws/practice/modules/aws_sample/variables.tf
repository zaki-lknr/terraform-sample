variable "vpc_cidr_block" {
    description = "CIDR Block of VPC"
    type        = string
    default     = "172.26.0.0/16"
}
# https://learn.hashicorp.com/tutorials/terraform/aws-variables

variable "prac_public_cidr_block" {
    description = "CIDR Block of Public Subnet"
    type        = string
    default     = "172.26.10.0/24"
}
variable "prac_private1_cidr_block" {
    description = "CIDR Block of Private1 Subnet"
    type        = string
    default     = "172.26.20.0/24"
}
variable "prac_private2_cidr_block" {
    description = "CIDR Block of Private2 Subnet"
    type        = string
    default     = "172.26.30.0/24"
}

