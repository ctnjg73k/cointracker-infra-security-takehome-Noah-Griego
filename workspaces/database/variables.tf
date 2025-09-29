# Defines a Terraform variable named "project" with the object data type. The object is composed of five properties:
# - "id": a string representing the ID of the project
# - "name": a string representing the name of the project
# - "region": a string representing the region where the project is located
# - "zone_primary": a string representing the primary zone for the project
# - "zone_secondary": a string representing the secondary zone for the project
variable "project" {
  type = object({
    id             = string
    name           = string
    region         = string
    zone_primary   = string
    zone_secondary = string
  })
}

# Defines a Terraform variable named "subnetwork" with the object data type. The object is composed of two properties:
# - "name": a string representing the name of the subnetwork
# - "cidr": a string representing the CIDR block of the subnetwork
variable "subnetwork" {
  type = object({
    name = string
    cidr = string
  })
}

# Defines a Terraform variable named "component_name" with the string data type. This variable represents the name of a component.
variable "component_name" {
  type = string
}

# Defines a Terraform variable named "cloudsql_instance_name" with the string data type. This variable represents the name of a Cloud SQL instance.
variable "cloudsql_instance_name" {
  type = string
}

# Defines a Terraform variable named "machine_type" with the string data type. This variable represents the machine type for the Cloud SQL instance.
variable "machine_type" {
  type = string
}

# Defines a Terraform variable named "network_name" with the string data type. This variable represents the name of the network.
variable "network_name" {
  type = string
}

# Defines a Terraform variable named "router_name" with the string data type. This variable represents the name of the router.
variable "router_name" {
  type = string
}

# Defines a Terraform variable named "db_version" with the string data type. This variable represents the version of the database. The default value is "POSTGRES_14".
variable "db_version" {
  type    = string
  default = "POSTGRES_14"
}

variable "db_name" {}
variable "db_user" {}
variable "db_pass" {}
