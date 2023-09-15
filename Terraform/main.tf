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
#créer VPC          #le réseau qui basiquement gère tout
#créer subnets (3)  #les sous-réseaux
#créer TableRoot    #créé les liens entre les différentes étape
#créer Gateway      #accès internet


#création instances
resource "aws_instance" "workers" {
  count = var.counter
  ami           = "ami-091b37bfd6e01db4f"
  instance_type = "t2.micro"

  tags = {
    Name = "instance_worker_${count.index+1}"
  }
}

resource "aws_instance" "master" {
  ami           = "ami-091b37bfd6e01db4f"
  instance_type = "t2.micro"

  tags = {
    Name = "instance_master"
  }
}

variable "counter" {
    type        = number
    default     = 3
}