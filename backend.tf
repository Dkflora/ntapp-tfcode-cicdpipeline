# S3 backend for remote state storage (no locking since you removed DynamoDB).
terraform {
  backend "s3" {
    bucket = "makasiw7backet"  # Replace with actual bucket name (or use var; don't commit real value).
    key    = "statew10/terraform.tfstate"
    region = "us-east-1"  # Match your provider region.
    # encrypt = true  # Uncomment for server-side encryption (recommended).
  }
}
