#! Creating the EC2 Instances and Security Groups
resource "aws_security_group" "sg" {
  name        = "myvpc_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "sg"
  }
  egress {
    from_port   = 0    # To Indicate any port
    to_port     = 0    # To Indicate any port
    protocol    = "-1" #TCP
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "ansible_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = base64encode(file("userdata.sh"))
  key_name               = var.key_name
  tags = {
    Name = "ansible_instance"
  }
}
