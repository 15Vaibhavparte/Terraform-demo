data "aws_vpc" "default" {
  cidr_block = "172.31.0.0/16"

}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.49.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "var.subnet_name"
  }
}


resource "aws_key_pair" "my_key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_security_group" "dynamic_sg" {
  name        = "dynamic-security-group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = data.aws_vpc.default.id
  #Dynamic ingress for SSH and HTTP traffic, k8s cluster port 30000 to 32767, and all egress traffic
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # All egress traffic
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "dynamic-security-group"
    Environment = var.env
  }
}


resource "aws_instance" "my_instance" {
  for_each = tomap({
    # terra-server-micro = "t3.micro"
    terra-server-medium = "t3.medium"
  })
  ami                    = var.ami_id
  key_name               = aws_key_pair.my_key.key_name
  instance_type          = each.value
  vpc_security_group_ids = [aws_security_group.dynamic_sg.id]
  subnet_id              = aws_subnet.my_subnet.id
  #   user_data = file("resource.sh")

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
  }

  tags = {
    Name = each.key
  }
}


