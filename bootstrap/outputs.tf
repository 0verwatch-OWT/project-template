output "deploy_role_arn" {
  description = "Set this as the repository variable DEPLOY_ROLE_ARN."
  value       = aws_iam_role.deploy.arn
}

output "state_bucket" {
  description = "Use this bucket in the backend block of every other Terraform root."
  value       = aws_s3_bucket.state.bucket
}
