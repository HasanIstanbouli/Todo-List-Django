# TODO: Enable S3 backend
# terraform {
#   backend "s3" {
#     bucket         = ""
#     key            = "envs/${terraform.workspace}/main/k8s_tooling/terraform.tfstate"
#     region         = ""
#     dynamodb_table = "" # optional for state locking
#     encrypt        = true
#   }
# }
