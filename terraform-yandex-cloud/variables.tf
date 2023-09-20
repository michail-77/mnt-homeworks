# **variables.tf**:
# ```hcl
variable "yandex_cloud_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
}

variable "yandex_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
}
