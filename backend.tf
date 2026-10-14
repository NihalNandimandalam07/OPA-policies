terraform {
  backend "s3" {
    bucket       = "opa-terraform-state-backend-nn"
    key          = "terraform-state/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true

  }
}