variable "gcp_credentials" {
  description = "The path to the GCP credentials file"
  default     = "./keys/credentials.json"
}

variable "gcs_bucket_location" {
  description = "The location/region of the bucket resources"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "My BigQuery datataset name"
  default     = "example_dataset"
}

variable "bq_location" {
  description = "The location/region of the BigQuery dataset"
  default     = "US"
}

variable "gcs_bucket_name" {
  description = "My storage bucket name"
  default     = "terraform-demo-412321-terraform-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage class"
  default     = "STANDARD"
}

variable "gc_project" {
  description = "The GCP project to deploy resources"
  default     = "terraform-demo-412321"
}

variable "gc_region" {
  description = "The GCP region to deploy resources"
  default     = "us-central1"
}
