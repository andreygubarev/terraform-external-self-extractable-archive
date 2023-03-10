variable "description" {
  type = string
  default = "MakeSelf Archive"

  description = "The label that describes the archive."
}

variable "source_dir" {
  type = string

  description = "The directory that contains the files to be archived."
}

variable "entrypoint" {
  type = string
  default = "entrypoint.sh"

  description = "The script to run when the archive is extracted."
}

variable "file_name" {
  type = string
  default = "makeself.run"

  description = "The name of the archive file."
}

variable "needroot" {
  type    = bool
  default = false

  description = "Whether the script needs to be run as root."
}

