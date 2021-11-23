# TiloRes Fake API Module for Terraform

Terraform module which creates the required resources to deploy a customized
fake API for testing purposes.

This module is typically used by the [`tilores-cli`](https://github.com/tilotech/tilores-cli) when running:

```
tilores-cli deploy fake-api
```

## Usage

```hcl
module "tilores" {
  source = "tilotech/tilores-fake-api/aws"

  region          = "eu-west-1"
  resource_prefix = "mycompany-dev"
  api_file        = "path/to/api.zip"
  dispatcher_file = "path/to/dispatcher.zip"
}
```