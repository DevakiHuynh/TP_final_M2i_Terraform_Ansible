#Créer TableRoute    #créé les liens entre les différentes étapes

resource "aws_network_interface" "test" {
  subnet_id = aws_subnet.k8s_subnet.id
}


resource "aws_route_table" "main" {
  vpc_id = aws_vpc.k8s_vpc.id

  tags = {
    Name = "kubernetes"
  }

  route {
    cidr_block           = "0.0.0.0/0"
    # network_interface_id = aws_network_interface.test.id
    gateway_id           = aws_internet_gateway.gw.id
  }

}