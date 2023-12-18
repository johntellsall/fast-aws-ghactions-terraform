# FIXME: bucket encryption
# FIXME: tf-admin user policy
# NOTE: add ddb lock?

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
  }
}

provider "aws" {
}

# AWS user with AmazonS3FullAccess to specific bucket
resource "aws_iam_user" "tf_admin" {
  name = "tf-admin"
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "johntellsall-202312-tf-state"
}


resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# NOTE: use template? external policy file?
resource "aws_iam_user_policy" "tf_admin_user_policy" {
  name = "tf-admin-user-policy"
  user = aws_iam_user.tf_admin.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::johntellsall-202312-tf-state",
        "arn:aws:s3:::johntellsall-202312-tf-state/*"
      ]
    }
  ]
}
EOF
}
