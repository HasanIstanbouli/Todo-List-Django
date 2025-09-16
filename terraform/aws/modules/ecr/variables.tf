variable "aws_region" {
  description = "AWS region"
  type        = string
}
variable "repository_name" {
  description = "ECR repository name"
  type        = string
}
variable "image_tag_mutability" {
  description = "Image tag mutability setting"
  type        = string
  default     = "MUTABLE"
}
variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}
variable "encryption_type" {
  description = "Encryption type for the repository"
  type        = string
  default     = "AES256"
}
variable "lifecycle_policy" {
  description = "Lifecycle policy for the repository"
  type        = string
  default     = null
}
variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
