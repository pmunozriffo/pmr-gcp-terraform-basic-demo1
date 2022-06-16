# BUCKETS
resource "google_storage_bucket" "buckets" {
  for_each                    = toset(local.bucket_names)
  name                        = each.value
  location                    = var.location
  force_destroy               = false
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "archive" {
  for_each                    = toset(local.archive_bucket_names)
  name                        = each.value
  location                    = var.location
  force_destroy               = false
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}
