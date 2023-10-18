# Terraform Module for Self-Extractable Archive

This module creates a self-extractable archive from a directory using [makeself](https://makeself.io/). The archive can be used to bootstrap a new instance using cloud-init.

## Usage

Quick start:

```terraform
module "bootstrap" {
  source      = "andreygubarev/self-extractable-archive/external"
  source_dir = "${path.module}/bootstrap"
}
```

Advanced usage:

```terraform
module "bootstrap" {
  source  = "andreygubarev/self-extractable-archive/external"
  version = "1.2.0"

  source_dir    = "${path.module}/bootstrap"
  file_name      = "bootstrap.run"
  startup_script = "./entrypoint.sh"
}
```

## Prerequisite

For MacOS:
```bash
brew install gnu-tar
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
```



# Reference

- https://makeself.io/
- https://registry.terraform.io/providers/hashicorp/external/latest
