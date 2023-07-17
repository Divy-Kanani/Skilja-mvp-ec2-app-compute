

resource "aws_iam_role" "app_instance_role" {
  name = "app-instance-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_security_group" "app_instance_security_group" {
  name        = "app-instance-security-group"
  description = "Skilja app instance security group"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

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

resource "aws_instance" "app_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "skilja-app-instance-key"
  subnet_id     = split(",", data.aws_ssm_parameter.private_subnets.value)[0]

  vpc_security_group_ids = [aws_security_group.app_instance_security_group.id]
  iam_instance_profile   = aws_iam_role.app_instance_role.name

  tags = {
    Name = "app-instance"
  }
}

