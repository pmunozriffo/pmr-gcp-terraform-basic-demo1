terraform {
    required_version = "~> 1.1.2"
    backend "gcs" {
    prefix = "template/"
    }
    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "~> 4.5.0"
        }
    }
}

locals {
    env        = "dev"
    project_id = "[MY_PROJECT]"
    location   = "EU"
    region     = "europe-west1"
}

provider "google" {
    project = local.project_id
}

# Create initial ressources (Cloud build triggers, activates apis, creates a custom sa to deploy bq queries)
#-- As a prerequisite you still need a Github orga owner to connect the repo to your project via the GUI.
#-- Start by commenting the usecase module and applying the init module

module "template" {
  source          = "../../modules/template"
  env             = local.env
  project_id      = local.project_id
  location        = local.location
  region          = local.region
  access_policies = local.security_policies
}
