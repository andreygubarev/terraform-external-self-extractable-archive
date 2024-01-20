# Terraform Module for Self-Extractable Archive

This module creates a self-extractable archive from a directory using [makeself](https://makeself.io/). The archive can be used to bootstrap a new instance using cloud-init.

Module uses `external` provider to run `makeself` command. It creates temporary directory, copies source directory to it, runs `makeself` and returns path to the archive.

Module targets to build hermetic self-extractable archives. It uses `--nomd5 --nocrc` options to disable checksums.

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
module "userdata" {
  source  = "andreygubarev/self-extractable-archive/external"
  version = "1.2.0"

  description        = "User Data"                 # Description of the archive
  filename           = "userdata.run"              # Name of self-extractable archive
  source_dir         = "${path.module}/userdata"   # Directory to be archived
  source_entrypoint  = "entrypoint.sh"             # Entrypoint script, relative to source_dir, defaults to "entrypoint.sh"
  source_environment = {
    FOO = "BAR"                                    # Environment variables to be exported, defaults to {}
  }
}

data "cloudinit_config" "this" {
  gzip          = true
  base64_encode = true

  part {
    filename     = basename(module.userdata.path)
    content_type = "text/x-shellscript"
    content      = file(module.userdata.path)
  }
}

output "userdata" {
  value = data.cloudinit_config.this.rendered
}
```

Example `entrypoint.sh`:

```bash
#!/bin/bash
set -euxo pipefail
source .env

# ...
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
