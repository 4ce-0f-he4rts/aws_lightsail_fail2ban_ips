provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["${var.aws_shared_credentials_files}"]
  profile                  = var.aws_profile

  default_tags {
    tags = {
      Provisioned = var.env
    }
  }
}

terraform {
  required_version = "~>1.8.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.46.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0.5"
    }
    null = {
      source  = "hashicorp/null"
      version = "~>3.2.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "~>2.5.1"
    }
    ansible = {
      source  = "ansible/ansible"
      version = "~>1.2.0"
    }
  }

  backend "local" {
    path = "aws_lightsail_fail2ban_ips/terraform.tfstate"
  }
}
