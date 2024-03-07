##########################################################################################
## Ensure default GCS Storage account can encrypt/decrypt on the cryto key(s):
data "google_storage_project_service_account" "gcs_account" {
  project = "tfc-sip-01"
}

##########################################################################################
## Ensure default Pub/Sub service account can encrypt/decrypt on the cryto key(s):
resource "google_project_service_identity" "pubsub-sa" {
  provider = google-beta
  project  = "tfc-sip-01"
  service  = "pubsub.googleapis.com"
}

##########################################################################################
## Ensure default Logging service account can encrypt/decrypt on the cryto key(s):
resource "google_project_service_identity" "logging-sa" {
  provider = google-beta
  project  = "tfc-sip-01"
  service  = "logging.googleapis.com"
}

resource "google_kms_crypto_key_iam_binding" "cmek_bindings" {
  crypto_key_id = module.cmek_key.self_link
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}",
    "serviceAccount:${google_project_service_identity.pubsub-sa.email}",
    "serviceAccount:${google_project_service_identity.secretmanager-sa.email}",
    "serviceAccount:${google_project_service_identity.logging-sa.email}"
  ]
}
