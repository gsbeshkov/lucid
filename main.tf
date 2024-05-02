terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.14"
}

provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "lucid-tfstate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

