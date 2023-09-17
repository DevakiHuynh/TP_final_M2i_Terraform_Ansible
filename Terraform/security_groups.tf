#Création des security groups

resource "aws_security_group" "k8s_security" {
  name        = "k8s_security"
  vpc_id      = aws_vpc.k8s_vpc.id
  description = "Kubernetes security group"

  tags = {
    Name = "kubernetes"
  }
}
resource "aws_security_group_rule" "vpc_security" {
  type        = "ingress"
  description = "from VPC"
  from_port   = 0
  to_port     = 0
  protocol    = "-1" #equivalent à all
  cidr_blocks = [aws_vpc.k8s_vpc.cidr_block]

  security_group_id = aws_security_group.k8s_security.id
}

resource "aws_security_group_rule" "worker_security" {
  type        = "ingress"
  description = "for workers"
  from_port   = 0
  to_port     = 0
  protocol    = "-1" #equivalent à all
  cidr_blocks = ["10.200.0.0/16"]

  security_group_id = aws_security_group.k8s_security.id

}

resource "aws_security_group_rule" "ssh_security" {
  type        = "ingress"
  description = "autorisation trafic ssh depuis toutes les adresses IP"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.k8s_security.id
}

resource "aws_security_group_rule" "p6443_security" {
  type        = "ingress"
  description = "autorisation trafic sur port 6443 depuis toutes les adresses IP"
  from_port   = 6443
  to_port     = 6443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.k8s_security.id
}

resource "aws_security_group_rule" "p443_security" {
  type        = "ingress"
  description = "autorisation trafic sur port 443 depuis toutes les adresses IP"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.k8s_security.id
}

resource "aws_security_group_rule" "icmp_security" {
  type        = "ingress"
  description = "autorisation trafic ICMP depuis toutes les adresses IP" #utiliser pour diagnostiquer les pbs réseaux
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.k8s_security.id
}