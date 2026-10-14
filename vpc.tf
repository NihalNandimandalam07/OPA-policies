resource "aws_vpc" "opa_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    name = "OPA-VPC"
  }
}

resource "aws_subnet" "opa_subnet" {
  vpc_id                  = aws_vpc.opa_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    name = "OPA-SUBNET"
  }

  depends_on = [aws_vpc.opa_vpc]
}

resource "aws_internet_gateway" "opa_igw" {
  vpc_id = aws_vpc.opa_vpc.id

  tags = {
    Name = "OPA-IGW"
  }

  depends_on = [aws_vpc.opa_vpc]
}

resource "aws_route_table" "opa_route_table" {
  vpc_id = aws_vpc.opa_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.opa_igw.id
  }

  tags = {
    Name = "OPA-ROUTE-TABLE"
  }

  depends_on = [aws_vpc.opa_vpc]
}

resource "aws_route_table_association" "opa_route_table_association" {
  subnet_id      = aws_subnet.opa_subnet.id
  route_table_id = aws_route_table.opa_route_table.id

  depends_on = [
    aws_subnet.opa_subnet,
    aws_route_table.opa_route_table
  ]
}