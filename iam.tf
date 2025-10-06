terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws    = { source = "hashicorp/aws",   version = ">= 5.40.0" }
    random = { source = "hashicorp/random", version = ">= 3.5.1" }
  }
}

provider "aws" { region = var.region }

resource "random_id" "suffix" {
  count       = var.add_random_suffix ? 1 : 0
  byte_length = 2
}

locals {
  base_name = "${var.appname}-${var.env}-${var.role_suffix}"
  role_name = var.add_random_suffix ? "${local.base_name}-${random_id.suffix[0].hex}" : local.base_name
}

data "aws_iam_policy_document" "trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = [var.trust_service]   # e.g., lambda.amazonaws.com, scheduler.amazonaws.com, synthetics.amazonaws.com
    }
  }
}

resource "aws_iam_role" "this" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.trust.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "basic_logs" {
  count      = var.attach_basic_logs ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "extra" {
  for_each   = toset(var.managed_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}

output "iam_role_name" { value = aws_iam_role.this.name }
output "iam_role_arn"  { value = aws_iam_role.this.arn }
