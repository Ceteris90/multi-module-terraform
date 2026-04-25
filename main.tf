terraform {
  # Change this !!! Use your own s3 bucket and DynamoDB instead!
  backend "s3" {
    bucket         = "my-terraform-state-bucket-kwame"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "kwame-terraform-lock"
  }

  required_providers {
    aws    = { source = "hashicorp/aws", version = "~> 6.0" }    # Provider (plugins) that talks with AWS
    tls    = { source = "hashicorp/tls", version = "~> 4.0" }    # Provider (plugins) that does SSH stuff
    random = { source = "hashicorp/random", version = "~> 3.0" } # Provider (plugins) that does "random numbers" stuff
    local  = { source = "hashicorp/local", version = "~> 2.0" }  # Provider (plugins) that creates files
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "my-infrastructure" {
  source        = "./modules/computer_storage"
  instance_name = "my-ec2-${each.value}"
  instance_type = "t3.micro"
  ami_id        = "ami-0a0823e4ea064404d"
  bucket_prefix = "my-kwame-bucketus"
  key_name      = "kwame-key-${each.value}"
  for_each      = var.instance-names
}