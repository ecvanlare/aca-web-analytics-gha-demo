variable "resource_group_name" {
  description = "The name of the resource group for the Web Analytics infrastructure"
  type        = string
  default     = "rg-web-analytics-bootstrap"
}

variable "resource_group_location" {
  description = "The Azure region where the resource group will be created"
  type        = string
  default     = "uksouth"
}

variable "storage_account_name" {
  description = "The name of the storage account used to store Terraform state"
  type        = string
  default     = "stwebanalyticsbootstf"
}

variable "storage_container_name" {
  description = "The name of the storage container used to store Terraform state"
  type        = string
  default     = "tfstate"
}

variable "storage_container_access_type" {
  description = "The access type for the storage container"
  type        = string
  default     = "private"
}

variable "storage_blob_versioning_enabled" {
  description = "Enable blob versioning for enhanced data protection"
  type        = bool
  default     = true
}

variable "storage_soft_delete_retention_days" {
  description = "Number of days to retain deleted blobs for soft delete protection"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    environment = "bootstrap"
    project     = "web-analytics"
    managed_by  = "terraform"
    application = "umami"
  }
}