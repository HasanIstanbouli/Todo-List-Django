variable "project_environment" {
  type        = string
  description = "the environment for this project"
}

variable "name" {
  type        = string
  description = "project nme"
}

variable "resources" {
  type = set(string)
  default = []
  description = "resources for this project"
}