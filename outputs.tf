output "path" {
  value = data.external.this.result.path
}

output "content" {
  value     = file(data.external.this.result.path)
  sensitive = true
}

output "checksum" {
  value = filemd5(data.external.this.result.path)
}

output "filename" {
  value = var.filename
}
