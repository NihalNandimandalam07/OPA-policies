#OPA Compliant SG
resource "aws_security_group" "sg_1" {
  name   = "opa-compliant-sg"
  vpc_id = aws_vpc.opa_vpc.id

  ingress {
    description = "SSH open to approved CIDR block"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "OPA-Compliant-Security-Group"
  }

  depends_on = [aws_vpc.opa_vpc]

}


#OPA Non-Compliant SG
resource "aws_security_group" "sg_2" {
  name   = "opa-non-compliant-sg"
  vpc_id = aws_vpc.opa_vpc.id

  ingress {
    description = "SSH open to everyone"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP open to everyone"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "OPA-Non-Compliant-Security-Group"
  }

  depends_on = [ aws_vpc.opa_vpc ]

}


#testing