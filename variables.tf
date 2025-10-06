variable "env"     { description = "Environment (lowercase)"; type = string }
variable "appname" { description = "Application name";        type = string }
variable "region"  { description = "AWS region";              type = string }

variable "trust_service" {
  description = "Service principal that will assume the role"
  type        = string
  default     = "lambda.amazonaws.com"
}

variable "role_suffix" {
  description = "Short suffix for the role name"
  type        = string
  default     = "uptime-role"
}

variable "attach_basic_logs" {
  description = "Attach AWSLambdaBasicExecutionRole managed policy"
  type        = bool
  default     = true
}

variable "managed_policy_arns" {
  description = "Extra policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "add_random_suffix" {
  description = "Append short random suffix to role name"
  type        = bool
  default     = true
}
