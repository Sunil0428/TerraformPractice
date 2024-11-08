resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-09c813fb71547fc4f"    # Replace with the AMI ID of your preferred OS
  instance_type = "t3.micro"                 # Instance type, e.g., t2.micro, m5.large
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  # (Optional) Add tags to identify the instance
  tags = {
    Name = "MyEC2Instance"
  }
}

resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
}

output "instance_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}