#Création instances 
#A finir, ajouter les références aux sous-réseaux et autres trucs


resource "aws_instance" "k8s_workers" {
  count         = var.counter
  ami           = "ami-091b37bfd6e01db4f"
  instance_type = "t2.micro"
#   key_name      = "devaki-accesskey"
  subnet_id     = aws_subnet.k8s_subnet.id
  associate_public_ip_address = true

  private_ip = "10.0.1.2${count.index}"

  vpc_security_group_ids = [aws_security_group.k8s_security.id]

  #script execute au lancement de l'instance
  user_data = <<-EOF
                  name = dev-worker-${count.index}|pod-cidr=10.200.${count.index}.0/24
                  EOF

  tags = {
    Name = "worker_${count.index + 1}"
  }

  root_block_device {
    # device_name = "/dev/sda1"
    volume_size = 50
  }

  # instance_id=$(aws ec2 run-instances \
  #     --associate-public-ip-address \
  #     --output text --query 'Instances[].InstanceId')
  #   aws ec2 modify-instance-attribute --instance-id ${instance_id} --no-source-dest-check

}



variable "counter" {
  type    = number
  default = 3
}