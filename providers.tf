terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "ue1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "ue2"
  region = "us-east-2"
}

provider "aws" {
  alias  = "uw1"
  region = "us-west-1"
}