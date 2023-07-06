terraform {
  cloud {
    organization = "TheBridge"

    workspaces {
      name = "terraform-infraestructura-como-codigo"
    }
  }
}

provider "aws"{
  region="eu-west-3"
}

resource "aws_instance" "servidor" {
  ami = "ami-05b5a865c3579bbc4"
  instance_type = "t2.micro"
}