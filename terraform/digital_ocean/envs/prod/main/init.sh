#!/bin/bash

# Load from environment (could come from .env file or CI/CD secrets)
: "${TF_PROD_BACKEND_BUCKET:?Missing TF_PROD_BACKEND_BUCKET}"
: "${TF_PROD_MAIN_APP_BACKEND_KEY:?Missing TF_PROD_MAIN_APP_BACKEND_KEY}"
: "${TF_PROD_BACKEND_REGION:?Missing TF_PROD_BACKEND_REGION}"
# For S3 to work...
: "${AWS_ACCESS_KEY_ID:?Missing AWS_ACCESS_KEY_ID}"
: "${AWS_SECRET_ACCESS_KEY:?Missing AWS_SECRET_ACCESS_KEY}"
: "${SPACES_ACCESS_KEY_ID:?Missing SPACES_ACCESS_KEY_ID}"
: "${SPACES_SECRET_ACCESS_KEY:?Missing SPACES_SECRET_ACCESS_KEY}"


terraform init \
  -backend-config="bucket=${TF_PROD_BACKEND_BUCKET}" \
  -backend-config="key=${TF_PROD_MAIN_APP_BACKEND_KEY}" \
  -backend-config="region=${TF_PROD_BACKEND_REGION}"
