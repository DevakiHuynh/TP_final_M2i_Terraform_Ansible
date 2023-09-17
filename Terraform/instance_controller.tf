#Création instance controller (master)

resource "aws_instance" "k8s_controller" {
  ami           = "ami-091b37bfd6e01db4f"
  instance_type = "t2.micro"
#   key_name      = "dev_accesskey"
  associate_public_ip_address = true    #attribuée automatiquement
  vpc_security_group_ids = [aws_security_group.k8s_security.id]
  private_ip = "10.0.1.10"
  subnet_id     = aws_subnet.k8s_subnet.id

  user_data = <<-EOF
                  name = dev-controller
                  EOF


  tags = {
    Name = "dev-controller"
  }

  root_block_device {
    # device_name = "/dev/sda1" #ne marche pas, mais est attribué automatiquement
    volume_size = 50
  }

}



# instance_id=$(aws ec2 run-instances \
#     --user-data "name=controller-${i}" \
#   aws ec2 modify-instance-attribute --instance-id ${instance_id} --no-source-dest-check
