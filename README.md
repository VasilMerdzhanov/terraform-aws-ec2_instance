# terraform-aws-ec2_instance

## Purpose
The purpose of this module is to deploy EC2 instance in AWS, using Terraform AWS provider

## Explanation
The module is using AWS provider version 4.63.0. It contains four blocks:
+ **terraform** - block is needed to ensure that correct plugin version is downloaded.
+ **data.aws_ami.ubuntu** - block is used to get list of AMI IDs in specific region (*see requirements how to set region*) and to filter results by name: **ubuntu-jammy-22.04-amd64-server-* **
+ **data.aws_key_pair.search_for_key_pair** - block is used to get list of previously stored key pairs in specific region (*see requirements how to set region*) in order to create EC2 with existing keypair to enable future login options.
+ **resource.aws_instance.VM** - block is creating EC2 instance with mentioned above parameters and with type `t2.micro`.


## Requirements
To ensure proper authentication with AWS and location on EC2, module expects following environment variables to be defined:
* AWS_ACCESS_KEY
* AWS_SECRET_ACCESS_KEY
* AWS_REGION / AWS_DEFAULT_REGION

If you are using **localy Terraform open source** on MAC/Linux platform or with **Terraform Cloud CLI-driven run** you can achieve this by
1. Run following commands in terminal:
```
export AWS_ACCESS_KEY=<your_AWS_access_key>
export AWS_SECRET_ACCESS_KEY=<your_AWS_secret_access_key>
export AWS_REGION=<your_AWS_region>
```
You can verify that variable are set when you run command `export` in same terminal.

2. Create variable set *(only for Terraform Cloud runs)*
Please find detailed guide how to do it [here](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-create-variable-set).

3. Add credential details directly in provider configuration block ***(highly not recommended)***
```
provider "aws" {
  region = "<your_region>"
  access_key = "<your_AWS_access_key>"
  secret_key = "<your_AWS_secret_access_key>"
}
```
## Usage
Module can be used in any terraform configuration files with the following example:
```
module "EC2_instance" {
source = "github.com/IvanGavrilov777/terraform-aws-ec2_instance"
}
```
### Terraform Cloud section
In case if you want to use this module in CLI-driven run in Terraform Cloud, you should add ***cloud {} block*** in your terraform block:
```
terraform {
  cloud {
    organization = "<name_of_your_organization>"
    workspaces {
      name = "<name_of_your_workspace>"
    }
  }
}
```
