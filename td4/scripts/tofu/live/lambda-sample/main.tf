provider "aws" {
  region = "us-east-1" # Ou ta région habituelle
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda_test"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Sid = "", Principal = { Service = "lambda.amazonaws.com" } }]
  })
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "sample-lambda-test"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  source_code_hash = data.archive_file.lambda.output_base64sha256
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "index.js"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function_url" "url" {
  function_name      = aws_lambda_function.test_lambda.function_name
  authorization_type = "NONE"
}
