variable "label" {
  type = string

  validation {
    condition     = can(regex("^[-a-z]+$", var.label))
    error_message = "Invalid value: label."
  }
}

variable "archive_dir" {
  type = string
}

variable "startup_script" {
  type = string
}

variable "file_name" {
  type = string
}

variable "needroot" {
  type    = bool
  default = false
}
