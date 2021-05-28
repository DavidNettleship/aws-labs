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

#internet gateways
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_egress_only_internet_gateway" "EIGW" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "EIGW"
  }
}

#NAT gateway & EIP
resource "aws_nat_gateway" "NATGW" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "NAT Gateway"
  }
}

resource "aws_eip" "eip" {
  vpc = true
}

#routes & route tables
resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.EIGW.id
  }

  tags = {
    Name = "Default Route Table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.EIGW.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
