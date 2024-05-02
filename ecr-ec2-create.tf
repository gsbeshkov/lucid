variable "project_name" {
  description = "The name of the project, used to tag resources"
  default     = "MyProject"
}

resource "aws_ecr_repository" "my_website" {
  name                 = "${var.project_name}-repo"
  image_tag_mutability = "MUTABLE"
}

resource "aws_iam_role" "lucid_role" {
  name = "lucid_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin_policy_attachment" {
  role       = aws_iam_role.lucid_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.lucid_role.name
}

resource "aws_instance" "web_instance" {
  ami           = "ami-0a1179631ec8933d7"
  instance_type = "t3.micro"
  user_data     = file("setup.sh")
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "${var.project_name}-ec2"
  }
}
