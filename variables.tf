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

################################################################################
# Workload
################################################################################
variable "archive_dir" {
  type = string
}

variable "startup_script" {
  type = string
}

variable "needroot" {
  type = bool
}
