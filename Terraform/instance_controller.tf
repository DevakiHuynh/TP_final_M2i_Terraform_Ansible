resource "aws_instance" "controller" {
  ami           = "ami-091b37bfd6e01db4f"
  instance_type = "t2.micro"

  tags = {
    Name = "dev-controller"
  }
}