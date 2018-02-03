terraform {
  backend "s3" {
    bucket         = "terraboard-demo"
    key            = "wordpress"
    profile        = "sandbox"
    region         = "eu-west-1"
    dynamodb_table = "demo-terraform-statelock"
  }
}
