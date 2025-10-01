terraform {
  backend "s3" {
    bucket       = "makasiw7backet"
    key          = "week10/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = false
  }
}