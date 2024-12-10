terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  region              = "sa-saopaulo-1"
  auth                = "SecurityToken"
  config_file_profile = "DEFAULT"
}

resource "oci_database_autonomous_database" "database_frandb" {
  compartment_id     = "cp_cloud"
  db_name            = "FRANDB"
  cpu_core_count     = 1
  data_storage_size_in_gb = 20
  admin_password     = "Co13*12!#*aqwqA11!33Weu*as"
  db_workload        = "OLTP" # ou "DW" para data warehouse
  display_name       = "FRAN_DB"
}