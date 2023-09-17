#Créer VPC          #le réseau qui basiquement gère tout

resource "aws_vpc" "k8s_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "kubernetes_the_hard_way"
  }
}