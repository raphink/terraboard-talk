terraform {
  backend "s3" {
    bucket         = "terraboard-demo"
    key            = "env:/terraform_state"
    profile        = "sandbox"
    region         = "eu-west-1"
    dynamodb_table = "demo-terraform-statelock"
  }
}
