
# terraform-digitalocean-spaces-bucket
An Open Source Terraform module that creates Spaces on DigitalOcean.

Terraform documentation on Spaces
* [DigitalOcean Spaces](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/spaces_bucket)


*If you come across any problems, **please open an issue**.*

## Usage Examples
**Basic example**

    module  "spaces-bucket" {
	    source  = "rhysbeingsocial/spaces-bucket/digitalocean"
	    version = "0.1"
	    spaces = [{
		    "name" = "bucket-name"
		    "region" = "ams3"
		    "acl" = "private"
		    "cors_rule" = [{
                allowed_headers = ["*"]
                allowed_methods = ["GET"]
                allowed_origins = ["*"]
                max_age_seconds = 3000
		    }]
		    "lifecycle_rule" = {
                "enabled" = true
                "expiration" = {
                    days = 15
                }
		    }
		    "force_destroy" = false
	    }]
	}

---
If you're looking to try Digitalocean out, [sign up here](https://m.do.co/c/c067b1364cb6) and get $100 free credit.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.10.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_spaces_bucket.spaces](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/spaces_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_spaces"></a> [spaces](#input\_spaces) | List of Spaces you want to create | `any` | n/a | yes |
| <a name="input_spaces_default"></a> [spaces\_default](#input\_spaces\_default) | Default list of Spaces variables. We don't need to pass anything to this variable. | <pre>object({<br>    name   = string<br>    region = string<br>    acl    = string<br>    cors_rule = object({<br>      allowed_headers  = list(string)<br>      allowed_methods  = list(string)<br>      allowed_origins  = list(string)<br>      max_age_sections = number<br>    })<br>    lifecycle_rule = object({<br>      id = string<br>      prefix = string<br>      enabled = bool<br>      abort_incomplete_multipart_upload_days = number<br>      expiration = object({<br>        date = string<br>        days = number<br>        expired_object_delete_marker = bool<br>      })<br>      noncurrent_version_expiration = object({<br>        days = number<br>      })<br>    })<br>    versioning     = object({<br>      enabled = bool<br>    })<br>    force_destroy  = bool<br>  })</pre> | <pre>{<br>  "acl": null,<br>  "cors_rule": null,<br>  "force_destroy": null,<br>  "lifecycle_rule": null,<br>  "name": null,<br>  "region": null,<br>  "versioning": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The FQDN of the bucket (e.g. bucket-name.nyc3.digitaloceanspaces.com) |
| <a name="output_name"></a> [name](#output\_name) | The name of the bucket |
| <a name="output_region"></a> [region](#output\_region) | The name of the region |
| <a name="output_urn"></a> [urn](#output\_urn) | The uniform resource name for the bucket |

