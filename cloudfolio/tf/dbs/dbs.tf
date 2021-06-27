provider "aws" {
  region = "eu-west-2"
}

resource "aws_dynamodb_table" "cf_assets" {
  name           = "cf_assets"
  billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "ticker"

  attribute {
    name = "ticker"
    type = "S"
  }
}

resource "aws_dynamodb_table" "cf_historical_values" {
  name           = "cf_historical_values"
  billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
