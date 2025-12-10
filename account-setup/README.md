# Account Setup

This directory contains the terraform configuration for deploying application to different AWS Accounts `dev-01/stage-01/prod-01`

The project is designed with a two-step process:

1. Bootstrapping: A one-time setup per environment to create the S3 bucket for storing Terraform's remote state.

2. Infrastructure Management: The main Terraform configuration for deploying and managing the actual account resources (VPCs, IAM, etc.).

## Prerequisites

- Terraform
- AWS CLI
- make install

## Structure

- `account_vars/`: Contains the environment-specific variable definitions.

- `backends/`: Contains the S3 backend configuration files for each environment. These must be updated after bootstrapping.

- `modules/`: Stores the terraform modules (VPC, IAM etc.)

- `terraform_state/`: A separate Terraform module used only for creating the S3 state bucket itself.

- `Makefile`: Provides helper commands to simplify managing environments.

## Setup

### Step 1: Create the S3 Backend (One-Time Setup)

Before you can run the main configuration, you must create the S3 bucket to store the Terraform state. This is done using the `terraform_state/` configuration

\*run make commands from `account-setup/` folder

1. **Run the bootstrap command** for the environment you want to set up. The ENV variable defaults to dev-01.

```bash
# dev-01 environment
make bootstrap ENV="dev-01"

# stage-01 environment
make bootstrap ENV="stage-01"

# prod-01 environment
make bootstrap ENV="prod-01"

```

2. **Get the S3 Bucket Name from Output**. The make bootstrap command will run and output the name of the S3 bucket it created. It will look something like this:

```bash
Outputs:
s3_bucket_name = "terraform-state-illuminati-red-bull-{ENV}-{accountID}"

```

3. **Update Your Backend Config.** Copy the `s3_bucket_name` value from the output and paste it into the corresponding file in the `backends/` directory.

```bash
# backends/dev-01.tfbackend

bucket         = "my-tf-state-bucket-dev-01"  # <-- PASTE THE BUCKET NAME HERE
key            = "stage/terraform-state/terraform.tfstate"
region         = "us-east-1"
use_lockfile   = true
encrypt        = true

```

### Step 2: Manage Account Infrastructure

Once your backend configuration files are updated with the correct bucket names, you can run the main Terraform commands.

The Makefile handles pointing to the correct `.tfvar`s and `.tfbackend` files based on the `ENV` variable.

1. Make init with correct backend configuration

```bash
make init ENV="dev-01"
make init ENV="stage-01"
make init ENV="prod-01"

```

2. Make plan

```bash
make plan ENV="dev-01"
make plan ENV="stage-01"
make plan ENV="prod-01"

```

3. Make apply

```bash
make apply ENV="dev-01"
make apply ENV="stage-01"
make apply ENV="prod-01"

```

4. Make destroy

```bash
make destroy ENV="dev-01"
make destroy ENV="stage-01"
make destroy ENV="prod-01"

```
