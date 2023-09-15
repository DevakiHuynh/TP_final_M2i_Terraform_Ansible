terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-3"
}

#########################################################################
#Création instances 
#A finir, ajouter les références aux sous-réseaux et autres trucs


resource "aws_instance" "workers" {
  count = var.counter
  ami           = "ami-091b37bfd6e01db4f"
  instance_type = "t2.micro"

  tags = {
    Name = "worker_${count.index+1}"
  }
}

resource "aws_instance" "controller" {
  ami           = "ami-091b37bfd6e01db4f"
  instance_type = "t2.micro"

  tags = {
    Name = "controller"
  }
}

variable "counter" {
    type        = number
    default     = 3
}

#########################################################################
#Créer key_pair? To define inside the provider?

# resource "aws_key_pair" "deployer" {
#   key_name = "Devaki-accessKeys"

# }


#########################################################################
#Créer VPC          #le réseau qui basiquement gère tout

resource "aws_vpc" "k8s_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "kubernetes_the_hard_way"
  }
}

#########################################################################
#Créer subnetworks (3)  #les sous-réseaux

resource "aws_subnet" "k8s_subnet" {
  count       = 3
  vpc_id      = aws_vpc.k8s_vpc.id
  cidr_block  = "10.0.1.0/24"
  availability_zone = "eu-west-3"

  tags = {
    Name = "kubernetes"
  }

}

#########################################################################
#Créer Gateway      #accès internet

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.k8s_vpc.id

  tags = {
    Name = "kubernetes"
  }
}

#########################################################################
#Créer TableRoute    #créé les liens entre les différentes étape

resource "aws_network_interface" "test" {
  subnet_id = aws_subnet.k8s_subnet.id
}


resource "aws_route_table" "main" {
  vpc_id = aws_vpc.k8s_vpc.id

  tags = {
    Name = "kubernetes"
  }

  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id = aws_network_interface.test.id
    gateway_id = aws_internet_gateway.main.id
  }

}

#########################################################################
#Création des security groups

resource "aws_security_group" "k8s_security" {
  name = "k8s_security"
  vpc_id = aws_vpc.k8s_vpc.id
  description = "Kubernetes security group"

  tags = {
    Name = "kubernetes"
  }

  ingress = {
    description      = "from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"    #equivalent à all
    cidr_blocks      = [aws_vpc.main.cidr_block]

  }

  ingress = {
    description      = "from workers"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = "10.200.0.0/16"
  }

  ingress = {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = "0.0.0.0/0"    
  }

  ingress = {
    from_port        = 6443
    to_port          = 6443
    protocol         = "tcp"
    cidr_blocks      = "0.0.0.0/0"        
  }

  ingress = {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = "0.0.0.0/0"       
  }

  ingress = {
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = "0.0.0.0/0"        
  }


}