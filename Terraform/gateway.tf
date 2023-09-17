#Créer Gateway      #accès internet

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.k8s_vpc.id

  tags = {
    Name = "kubernetes"
  }
}