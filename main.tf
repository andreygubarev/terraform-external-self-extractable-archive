data "external" "this" {
  program = ["${path.module}/external.sh"]

  query = {
    makeself_bin        = "${path.module}/makeself.sh"
    makeself_header_bin = "${path.module}/makeself-header.sh"

    archive_dir    = var.archive_dir
    file_name      = var.file_name
    label          = var.label
    startup_script = var.startup_script

    gzip     = var.gzip
    needroot = var.needroot
  }
}

output "result" {
  value = data.external.this.result
}
