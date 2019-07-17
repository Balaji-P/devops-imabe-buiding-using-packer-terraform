variable "region" {
  default     = ""
  description = "Google Cloud region"
}

variable "project_id" {
  default     = ""
  description = "Project ID from environment"
}

variable "zone" {
  default     = ""
  description = "Google Cloud zone"
}

variable "network" {
  default = "default"
  description = "Default network"
}

variable "image" {
  default     = ""
  description = "Image for computing instance"
}

variable "nginx-tag" {
  default     = "nginx-task-tag"
  description = "Tag used for instance and firewalls"
}

variable "nginx-name" {
  default     = "nginx-task-vm"
  description = "Name of VM for nginx"
}


variable "machine_type" {
  default     = "f1-micro"
  description = "Instance type for nginx"
}

variable "ip_ranges" {
  type        = list
  default     = [ "194.183.168.0/24", "176.38.82.126/32" ]
  description = "IPs allowed in firewall"
}
