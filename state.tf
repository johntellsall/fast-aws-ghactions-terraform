terraform {
  backend "s3" {
    bucket = "johntellsall-202312-tf-state"
    key    = "state/terraform.tfstate"
    #    encrypt        = true
    #    kms_key_id     = "alias/terraform-bucket-key"
    #    dynamodb_table = "terraform-state"
  }
}

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
