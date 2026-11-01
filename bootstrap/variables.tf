variable "github_repository" {
  description = "This repository as owner/name, for example your-username/your-project. The deploy role trusts its main branch only."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9-]+/[A-Za-z0-9._-]+$", var.github_repository))
    error_message = "Use the form owner/name."
  }
}

variable "region" {
  description = "The region your account is allowed to use."
  type        = string
  default     = "us-east-1"
}
