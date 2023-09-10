module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "6.0.0"

  function_name = "cloud-resume-challenge-api"
  description   = "api to get and update visitor count from dynamodb table"
  handler       = "visitor_count.lambda_handler"
  runtime       = "python3.11"

  source_path = "${path.module}/lambda/visitor_counter.py"

  attach_policy_jsons = true

  number_of_policy_jsons = 2

  policy_jsons = [
    file("lambda/lambda_policy.json"),
    file("lambda/dynamodb_policy.json")
  ]

  create_lambda_function_url = true

  tags = local.common_tags
}

#outputs-----------------------------------------------------------------------------

output "lambda_function_url" {
  description = "URL of lambda function"
  value       = module.lambda.lambda_function_url
}

output "lambda_function_arn" {
  description = "ARN of lambda function"
  value       = module.lambda.lambda_function_arn
}

output "lambda_function_name" {
  description = "name of lambda function"
  value       = module.lambda.lambda_function_name
}
