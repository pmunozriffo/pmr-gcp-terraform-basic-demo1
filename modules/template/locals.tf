locals {


  domain_provider = {
    "template" = {
      "id"          = "d_template_${lower(var.location)}_${lower(var.env)}"
      "name"        = "template dataset"
      "description" = "template description"
      "tables" = {
        "t_template" = {
          "id"          = "t_template"
          "description" = "template Table"
          # "schema"      = file("${path.module}/../../schemas/t_template.json")
          # "clustering" = ["field1"]
          # "type" = "MONTH"
          # "field" = "Date"
          # "require" = false
        }
      }
      "views" = {
        "v_template" = {
          "description" = "template view"
        }
      }
      "access" = {}
    },
  }

  # replace with actual ref !
  scheduled_queries = {
    # "query_usecase" = {
    #   "name"                = "${local.domain_provider.template.tables.t_template.id}"
    #   "schedule"            = "first sunday of quarter 00:00"
    #   "destination_dataset" = "${local.domain_provider.template.id}"
    #   "params" = {
    #     "destination_table" = "${local.domain_provider.template.tables.t_template.id}"
    #     ### Either pass the query through here or have a default path
    #     #"query"             = templatefile("${path.module}/sql/scheduled_queries/${local.domain_provider.template.tables.t_template.id}.sql", { env = var.env })
    #     "write_disposition" = "WRITE_APPEND" # or WRITE_TRUNCATE
    #   }
    # }
  }


  schedulers = {
    # "wf__usecase" = {
    #   "description" = "Weekly execution for template"
    #   "schedule"    = "*/2 * * * *"
    #   "workflows"   = "bq_load"
    # }
  }


  bucket_names = [
    "${var.project_id}-template"
  ]
  # Archive buckets have a lifecycle policy
  archive_bucket_names = [
    "${var.project_id}-template-archive"
  ]

}
