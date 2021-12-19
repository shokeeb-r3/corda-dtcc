resource "aws_iam_instance_profile" "corda_iam_profile" {
  name = "${var.developer}_corda_iam_profile"
  role = "${var.developer}_corda_iam_role"
}

resource "aws_iam_role" "corda_iam_role" {
  name = "${var.developer}_corda_iam_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "corda_ssm_instance_attachment" {
  role       = aws_iam_role.corda_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

# resource "aws_iam_role_policy_attachment" "corda_s3-access" {
#   role       = aws_iam_role.corda_iam_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }