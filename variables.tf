variable "spaces" {
  description = "List of Spaces you want to create"
  type        = any
}

variable "spaces_default" {
  description = "Default list of Spaces variables. We don't need to pass anything to this variable."
  type = object({
    name   = string
    region = string
    acl    = string
    cors_rule = object({
      allowed_headers  = list(string)
      allowed_methods  = list(string)
      allowed_origins  = list(string)
      max_age_sections = number
    })
    lifecycle_rule = object({
      id = string
      prefix = string
      enabled = bool
      abort_incomplete_multipart_upload_days = number
      expiration = object({
        date = string
        days = number
        expired_object_delete_marker = bool
      })
      noncurrent_version_expiration = object({
        days = number
      })
    })
    versioning     = object({
      enabled = bool
    })
    force_destroy  = bool
  })

  default = {
    name           = null
    region         = null
    acl            = null
    cors_rule      = null
    lifecycle_rule = null
    versioning     = null
    force_destroy  = null
  }
}
