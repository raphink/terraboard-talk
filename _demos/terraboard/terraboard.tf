resource "aws_iam_user" "terraboard" {
  name = "terraboard-demo"
  path = "/services/"
}

resource "aws_iam_access_key" "terraboard" {
  user = "${aws_iam_user.terraboard.name}"
}

data "aws_iam_policy_document" "terraboard" {
  statement {
    sid = "ReadOnly"

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:GetObjectVersion",
    ]

    resources = [
      "${aws_s3_bucket.terraform-state.arn}/*",
      "${aws_s3_bucket.terraform-state.arn}",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_user.terraboard.arn}"]
    }
  }
}

resource "aws_iam_user_policy" "terraboard-dynamodb" {
  name = "terraboard-dynamodb"
  user = "${aws_iam_user.terraboard.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ReadOnly",
      "Action": [
        "dynamodb:Scan"
      ],
      "Effect": "Allow",
      "Resource": "${aws_dynamodb_table.terraform_statelock.arn}"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "terraboard" {
  bucket = "terraboard-test"
  policy = "${data.aws_iam_policy_document.terraboard.json}"
}
