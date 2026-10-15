data "aws_ami" "aws_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#Compliant EC2
resource "aws_instance" "ec2_1" {
  
  ami           = data.aws_ami.aws_ami.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.opa_subnet.id

  vpc_security_group_ids      = [aws_security_group.sg_1.id]
  associate_public_ip_address = false

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    name = "OPA-COMPLIANT-EC2-INSTANCE"
  }

  depends_on = [aws_subnet.opa_subnet, aws_security_group.sg_1]
}


#Non-Compliant EC2
resource "aws_instance" "ec2_2" {
  ami           = data.aws_ami.aws_ami.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.opa_subnet.id

  vpc_security_group_ids      = [aws_security_group.sg_1.id]
  associate_public_ip_address = false

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = false
  }

  tags = {
    name = "OPA-NON-COMPLIANT-EC2-INSTANCE"
  }

  depends_on = [ aws_subnet.opa_subnet, aws_security_group.sg_2 ]
}
