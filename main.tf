data "external" "this" {
  program = ["${path.module}/external.sh"]

  query = {
    makeself_bin        = abspath("${path.module}/makeself.sh")
    makeself_header_bin = abspath("${path.module}/makeself-header.sh")

    archive_dir    = abspath(var.archive_dir)
    file_name      = var.file_name
    label          = var.workload
    startup_script = var.startup_script

    needroot = var.needroot
  }
}

output "path" {
  value = data.external.this.result.path
}

output "content" {
  value = file(data.external.this.result.path)
}

output "checksum" {
  value = filemd5(data.external.this.result.path)
}
