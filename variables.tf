# Passed by the DPaaS template
variable "env"     { description = "Environment (lowercase)"; type = string }
variable "appname" { description = "Application name";        type = string }
variable "region"  { description = "AWS region";              type = string }

# IAM knobs
variable "trust_service" {
  description = "Service principal that assumes the role (e.g., lambda.amazonaws.com)"
  type        = string
  default     = "lambda.amazonaws.com"
}

variable "role_suffix" {
  description = "Short suffix for the role name"
  type        = string
  default     = "app-role"
}

variable "attach_basic_logs" {
  description = "Attach AWSLambdaBasicExecutionRole managed policy"
  type        = bool
  default     = true
}

variable "managed_policy_arns" {
  description = "Optional extra AWS managed policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "add_random_suffix" {
  description = "Append short random suffix to avoid name collisions"
  type        = bool
  default     = false
}
