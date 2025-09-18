variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}
variable "private_subnet_ids" {
  description = "Private subnet IDs for worker nodes"
  type        = list(string)
}
variable "kubernetes_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.30"
}
variable "desired_size" {
  description = "Desired node count"
  type        = number
  default     = 2
}
variable "min_size" {
  description = "Min node count"
  type        = number
  default     = 1
}
variable "max_size" {
  description = "Max node count"
  type        = number
  default     = 4
}
variable "instance_types" {
  description = "EC2 instance types for node groups"
  type        = list(string)
  default     = ["t3.medium"]
}
variable "capacity_type" {
  description = "EC2 capacity type for the node group"
  type        = string
  default     = "ON_DEMAND"
  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be either ON_DEMAND or SPOT."
  }
}
variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
