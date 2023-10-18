data "external" "this" {
  program = ["${path.module}/external.sh"]

  query = {
    makeself_bin        = abspath("${path.module}/makeself.sh")
    makeself_header_bin = abspath("${path.module}/makeself-header.sh")

    archive_dir    = abspath(var.source_dir)
    startup_script = var.source_entrypoint
    dotenv         = var.source_environment
    needroot       = var.needroot

    label     = var.description
    file_name = var.filename
  }
}
