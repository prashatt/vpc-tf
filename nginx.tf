resource "aws_instance" "nginx" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  subnet_id = aws_subnet.sn_public[0].id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  tags = {
    Name = "nginx-web"
  }
}
resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  description = "nginx Security Group for HTTP"
  vpc_id = aws_vpc.test_vpc.id

  ingress {
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

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}