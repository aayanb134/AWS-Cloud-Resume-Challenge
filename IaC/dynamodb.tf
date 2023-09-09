module "dynamodb-table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.3.0"

  name     = "cloud-resume-visitor-counter"
  hash_key = "ID"

  attributes = [
    {
      name = "ID"
      type = "S"
    },
    {
      name = "views"
      type = "N"
    }
  ]

  tags = local.common_tags
}

resource "aws_dynamodb_table" "visitor_count" {
  name     = module.dynamodb-table.dynamodb_table_id
  hash_key = "ID"
  item = jsonencode({
    ID    = { "S" : "1" },
    views = { "N" : 300 }
  })
}

output "dynamodb_table_arn" {
  description = "ARN of DynamoDB table"
  value       = module.dynamodb-table.dynamodb_table_arn
}

output "dynamodb_table_id" {
  description = "Name of DynamoDB table"
  value       = module.dynamodb-table.dynamodb_table_id
}
