terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-954"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}