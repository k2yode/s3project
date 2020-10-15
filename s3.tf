####################
#AWS Provider settings
####################

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

resource "aws_s3_bucket" "Website" {
  bucket = "k2yode.com"
  acl    = "public-read"

  tags = {
    Name        = "Website"
    Environment = "Prod"
  }


  website {
    index_document = "index.html"
  }
 
  policy = <<EOF

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadForGetBucketObjects",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::k2yode.com/*"
    }
  ]
}

EOF
}

resource "aws_s3_bucket_object" "website_object" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = "k2yode.com"
  source       = "index.html"
  content_type = "text/html"
}