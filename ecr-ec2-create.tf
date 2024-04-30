resource "aws_ecr_repository" "my_website" {
  name                 = "${var.project_name}-repo"
  image_tag_mutability = "MUTABLE"
}

resource "aws_instance" "web_instance" {
  ami           = "ami-0a1179631ec8933d7"
  instance_type = "t3.micro"
  user_data = "${file("setup.sh")}"

  tags = {
    Name = "${var.project_name}-ec2"
  }
}