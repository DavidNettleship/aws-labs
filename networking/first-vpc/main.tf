resource "aws_vpc" "main" {
  cidr_block                       = "192.168.0.0/16"
  assign_generated_ipv6_cidr_block = true
  instance_tenancy                 = "default"

  tags = {
    Name = "My First VPC"
  }
}

#subnets
resource "aws_subnet" "public" {
  vpc_id          = aws_vpc.main.id
  cidr_block      = "192.168.1.0/24"
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 161)
  tags = {
    Name = "Public"
  }
}

resource "aws_subnet" "private" {
  vpc_id          = aws_vpc.main.id
  cidr_block      = "192.168.2.0/24"
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 162)
  tags = {
    Name = "Private"
  }
}
