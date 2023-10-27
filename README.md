# Apache Flink AWS EMR Setup

Terraform script to setup Apache Flink on AWS EMR.

## Usage

Please follow these steps for usage.

### Create Configuration File

Create a `config.tfvars` file and update the variables:

```hcl
aws_profile = "<AWS_PROFILE>"
region      = "<AWS_REGION>"

## These values are used for AWS resource tags
project     = "<PROJECT_NAME>"
owner       = "<PROJECT_OWNER_NAME>"
environment = "<ENVIRONMENT>"

## EMR related examples configurations, please update them accordingly
emr_release_label       = "emr-6.9.1"
emr_main_instance_type  = "m5.xlarge"
emr_core_instance_type  = "m5.xlarge"
emr_core_instance_count = "2"
```

### Deploy Setup

Initialize the terraform:

```sh
terraform init
```

Get the terraform plan:

```sh
terraform plan -var-file config.tfvars -out terraform.tfplan
```

Deploy the plan:

```sh
terraform apply -var-file config.tfvars
```

This will ask your approval. You can also auto approve it, with the following
command:

```sh
terraform apply -auto-approve -var-file config.tfvars
```

_Please be patient, it will take some time to set up everything._

### Destroy the setup

Create a destroy plan:

```sh
terraform plan -destroy -var-file config.tfvars -out terraform.tfplan
```

Run the destroy action:

```sh
terraform apply terraform.tfplan
```

## License

[The MIT License (MIT)](LICENSE)
