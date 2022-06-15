data "archive_file" "dist" {
  source_dir       = "${path.module}/../dist"
  output_file_mode = "0666"
  output_path      = "${path.module}/.temp/lambda.zip"
  type             = "zip"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "humble-website"
  tags = {
    Environment = var.stage
    Name        = "Humble Website"
  }
  force_destroy = true
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  acl    = "private"
  bucket = aws_s3_bucket.bucket.id
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket              = aws_s3_bucket.bucket.id
  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_object" "bucket_object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "v${var.app_version}/${aws_s3_bucket.bucket.id}.zip"
  source = data.archive_file.dist.output_path
  etag   = filemd5(data.archive_file.dist.output_path)
}
