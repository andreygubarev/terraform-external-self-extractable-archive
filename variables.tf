################################################################################
# Workload
################################################################################

variable "workload" {
  type = string

  validation {
    condition     = can(regex("^[-a-z]+$", var.workload))
    error_message = "Invalid value: workload."
  }
}

locals {
  workload_prefix = "${var.workload}-"
}
