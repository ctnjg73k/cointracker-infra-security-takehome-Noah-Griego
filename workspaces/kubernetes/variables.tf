# Object that defines the GCP project information
variable "project" {
  type = object({
    id             = string # ID of the GCP project
    name           = string # Name of the GCP project
    region         = string # Region of the GCP project
    zone_primary   = string # Primary zone of the GCP project
    zone_secondary = string # Secondary zone of the GCP project
  })
}

# Name of the component to be deployed
variable "component_name" {
  type = string
}

# Machine type for the instance
variable "machine_type" {
  type = string
}

# Name of the VPC network to be created
variable "network_name" {
  type        = string
  description = "Name for the VPC network"
}

# Name of the router to be created
variable "router_name" {
  type = string
}

# Name of the cluster to be created
variable "cluster_name" {
  type = string
}

# Minimum number of instances in the autoscaling group
variable "min_count" {
  type = number
}

# Maximum number of instances in the autoscaling group
variable "max_count" {
  type = number
}

# Object that defines the subnetwork information
variable "subnetwork" {
  type = object({
    name = string # Name of the subnetwork to be created
    cidr = string # CIDR block of the subnetwork
  })
}

# Object that defines the IP range for services
variable "ip_range_services" {
  type = object({
    name = string # Name of the IP range for services
    cidr = string # CIDR block of the IP range for services
  })
}

# Object that defines the IP range for pods
variable "ip_range_pods" {
  type = object({
    name = string # Name of the IP range for pods
    cidr = string # CIDR block of the IP range for pods
  })
}

# Disk size for the instance in GB
variable "disk_size_gb" {
  type    = number
  default = 20
}

# Service account email address
variable "service_account" {
  description = "Service account email address"
  type        = string
  default     = ""
}

# Additional metadata to attach to the instance
variable "additional_metadata" {
  type        = map(any)
  description = "Additional metadata to attach to the instance"
  default     = {}
}

# Flag to determine whether to expose dockersock
variable "dind" {
  type        = bool
  description = "Flag to determine whether to expose dockersock "
  default     = false
}

# The number of seconds that the autoscaler should wait before it starts collecting information from a new instance.
variable "cooldown_period" {
  description = "The number of seconds that the autoscaler should wait before it starts collecting information from a new instance."
  type        = number
  default     = 60
}
