# Must match pipeline parameters
env     = "sandbox"
appname = "QuickSetup"
region  = "us-east-1"

# IAM behavior
trust_service      = "lambda.amazonaws.com"   # change to "scheduler.amazonaws.com" or "synthetics.amazonaws.com" if needed
role_suffix        = "uptime-role"
attach_basic_logs  = true
managed_policy_arns = []                      # add ARNs if you want more policies
add_random_suffix  = true                     # set to false if you want a fixed name
