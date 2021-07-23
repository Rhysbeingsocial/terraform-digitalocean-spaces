terraform {
  required_version = ">= 1.0.1"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

locals {
  merge_default_config = [for space in var.spaces : merge(var.spaces_default, space)]
  iterator             = { for space in local.merge_default_config : space.name => space }
}

resource "digitalocean_spaces_bucket" "spaces" {
  for_each = local.iterator

  name   = each.key
  region = each.value.region
  force_destroy = each.value.force_destroy

  dynamic "cors_rule" {
    for_each = each.value.cors_rule[*]

    content {
      allowed_headers = try(cors_rule.value["allowed_headers"], null)
      allowed_methods = cors_rule.value["allowed_methods"]
      allowed_origins = cors_rule.value["allowed_origins"]
      max_age_seconds = try(cors_rule.value["max_age_seconds"], null)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_rule[*]

    content {
      id                                     = try(lifecycle_rule.value["id"], null)
      prefix                                 = try(lifecycle_rule.value["prefix"], null)
      enabled                                = lifecycle_rule.value["enabled"]
      abort_incomplete_multipart_upload_days = try(lifecycle_rule.value["abort_incomplete_multipart_upload_days"], null)
      expiration {
        date = try(lifecycle_rule.value.expiration["date"], null)
        days = try(lifecycle_rule.value.expiration["days"], null)
        expired_object_delete_marker = try(lifecycle_rule.value.expiration["expired_object_delete_marker"], null)
      }
      noncurrent_version_expiration  {
        days = try(lifecycle_rule.value.noncurrent_version_expiration["days"], null)
      }
    }
  }

  versioning {
    enabled = try(each.value.versioning.enabled, null)
  }
}
