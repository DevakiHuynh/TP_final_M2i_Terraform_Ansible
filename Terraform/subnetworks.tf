#Créer subnetworks (3)  #les sous-réseaux

resource "aws_subnet" "k8s_subnet" {
  # count       = 3
  vpc_id            = aws_vpc.k8s_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-3b"

  tags = {
    Name = "kubernetes"
  }

}