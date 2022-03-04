# This file defines baseline variables used across this TF deployment

# These will typically be provided at Runtime in a CI/CD pipeline from a key vault

variable "TENANT_ID" {
     default ="string"
}

variable "SUBSCRIPTION_ID" {
     default = "string"
}

variable "CLIENT_ID" {
     default = "string"
}

variable "CLIENT_SECRET" {
     default = "string"
}

variable "ENV_ID" {
     default ="string"
}

variable "DEMO_SECRET" {
     default ="string"
}

variable "ADMIN_LOGIN" {
     default ="string"
}

variable "ADMIN_PASSWORD" {
     default ="string"
}


