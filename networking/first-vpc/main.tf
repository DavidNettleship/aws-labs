resource "aws_vpc" "main" {
  cidr_block       = "192.168.0.0/16"
  assign_generated_ipv6_cidr_block = true
  instance_tenancy = "default"

  tags = {
    Name = "My First VPC"
  }
}
