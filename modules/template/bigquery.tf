#Change Provider to deploy Bigquery resources

/*
data "google_service_account_access_token" "default" {
  provider               = google
  target_service_account = "bq_deploy@${var.project_id}.iam.gserviceaccount.com"
  scopes                 = ["cloud-platform"]
  lifetime               = "600s"
}

provider "google" {
  project      = var.project_id
  alias        = "impersonated"
  access_token = data.google_service_account_access_token.default.access_token
}
*/


locals {
  rls_query = join("; ", [for key, value in var.access_policies : "CREATE OR REPLACE ROW ACCESS POLICY ${key}_filter ON ${var.project_id}.TEST_TABLE.TEST_TABLE GRANT TO (${join(", ", [for grantee in value.grantees : "'${grantee}'"])}) FILTER USING (${value.filter})"])

}

module "domain" {
  for_each        = local.domain_provider
  source          = "./modules/domain_provider"
  project_id      = var.project_id
  location        = var.location
  env             = var.env
  dataset_id      = each.value.id
  tables          = try(each.value.tables, {})
  views           = try(each.value.views, {})
  access          = try(each.value.access, {})
  access_policies = var.access_policies
  providers = {
    google = google
  }
}

# ROW LEVEL SECURITY JOB
resource "google_bigquery_job" "rls_job" {
  job_id   = "apply_rls_template_${md5(local.rls_query)}"
  location = var.location
  query {
    query              = local.rls_query
    create_disposition = ""
    write_disposition  = ""
  }
}
