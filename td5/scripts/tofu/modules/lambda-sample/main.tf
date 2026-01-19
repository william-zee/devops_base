resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_lambda_function" "test_lambda" {
  function_name = var.name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  # On crée un fichier zip vide pour que Tofu ne râle pas
  filename      = "lambda_function_payload.zip"
}
