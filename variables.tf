variable "label" {
  type = string

  description = "The label that describes the archive."
  validation {
    condition     = can(regex("^[-a-z]+$", var.label))
    error_message = "Invalid value: label."
  }
}

variable "archive_dir" {
  type = string

  description = "The directory that contains the files to be archived."
}

variable "file_name" {
  type = string

  description = "The name of the archive file."
}

variable "needroot" {
  type    = bool
  default = false

  description = "Whether the script needs to be run as root."
}

variable "startup_script" {
  type = string
  default = "entrypoint.sh"

  description = "The script to run when the archive is extracted."
}
