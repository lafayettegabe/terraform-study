resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "public_read_bucket" {
  bucket = "public-read-bucket-${random_id.bucket_suffix.hex}"
}

data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.public_read_bucket.arn}/*"
    ]
  }
}

output "iam_policy" {
  value = data.aws_iam_policy_document.static_website.json
}
