# Self-extractable archive

## Prerequisite

For MacOS:
```bash
brew install gnu-tar
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
```

## Usage Example
```terraform
module "bootstrap" {
  ...

  archive_dir    = "${path.module}/bootstrap"
  file_name      = "bootstrap.run"
  startup_script = "./entrypoint.sh"
}
```

# Reference

https://makeself.io/
