# terraform-azure-vault-db-secrets

**Automated provisioning of Azure Vault secrets and database credentials using Terraform Cloud and HCP Vault.**

---

## Overview

This repository provides a modular solution to manage secrets in **Azure** and **HCP Vault** using **Terraform**. The automation is orchestrated through a hierarchy of Terraform Cloud (TFC) workspaces, enabling scalable, repeatable, and secure infrastructure provisioning. The only manual step required is the initial bootstrap, after which all other workspaces and resources are managed automatically.

---

## Architecture

- **terraform-cloud/bootstrap**
  - Initializes Vault with the required authentication method for HCP Terraform.
  - Creates the initial TFC workspaces: `namespace-root` and `namespace-vending`.

- **terraform-cloud/namespace-root**
  - Provisions all necessary resources in the Vault root namespace.

- **terraform-cloud/namespace-vending**
  - Acts as the "parent" workspace, responsible for creating additional TFC workspaces (one per Vault namespace).

- **terraform-cloud/namespace-apps, terraform-cloud/namespace-delivery, terraform-cloud/namespace-arquitectura, ...**
  - Each workspace manages resources for its corresponding Vault namespace.

---

## Prerequisites

- **Terraform v1.0+**
- **Terraform Cloud account**
- **Vault cluster**
- **Azure account with permissions to create Key Vaults and related resources**

---

## Quick Start

### 1. Clone the repository

```
git clone https://github.com/amora-hc/terraform-azure-vault-db-secrets.git
cd terraform-azure-vault-db-secrets
```

### 2. Prepare configuration files

- Copy the example variables file and edit it with your environment details:

```
cp terraform-cloud/terraform.tfvars.example terraform-cloud/terraform.tfvars
```

Edit terraform-cloud/terraform.tfvars with your preferred editor

- Create a `.env` file in the `terraform-cloud` directory with the following content:

```
export VAULT_TOKEN=your-vault-root-token
export TFC_TOKEN=your-terraform-cloud-token
```

> **Note:** You must source this file before running any local Terraform commands in the bootstrap step.

### 3. Bootstrap (Manual Step)

This step must be run **locally** and only once per environment.

```
cd terraform-cloud/bootstrap
source ../.env
terraform init
terraform apply
```

- This will:
  - Enable the required Vault authentication method for HCP Terraform.
  - Create the initial TFC workspaces: `namespace-root` and `namespace-vending`.

#### 3.1. Bootstrap (Alternative approach)

In addition to running the bootstrap phase with Terraform locally (as described above), you can also perform the bootstrap by manually executing each command found in the `scripts/bootstrap.sh` script.

This provides a flexible alternative for users who prefer not to run Terraform locally or need to perform the bootstrap steps individually for troubleshooting or advanced automation scenarios.

- How to Use the Alternative Method:

The script `terraform-cloud/scripts/bootstrap.sh` contains all the necessary Vault CLI commands to initialize and configure the environment for this solution.

- Run Each Command Manually:

Instead of executing `terraform apply` for the bootstrap phase, you can open a terminal and run each command from the script in sequence.

Ensure you have the required environment variables and credentials set (as described in the prerequisites).

This approach is functionally equivalent to running the bootstrap with Terraform, but gives you granular control over each step.

- When to Use This Method:

If you encounter issues running Terraform locally.

If you want to perform or automate specific bootstrap steps.

For debugging or learning purposes.

> **Note:**  both methods (Terraform and manual script) achieve the same end state. Choose the approach that best fits your workflow.


### 4. Automated Workspace Provisioning

- After the bootstrap step, all other Terraform code is executed automatically in TFC workspaces:
  - `namespace-root` provisions root namespace resources.
  - `namespace-vending` provisions additional workspaces for each Vault namespace.
  - Each generated workspace (e.g., `namespace-apps`, `namespace-delivery`, etc.) provisions resources for its respective namespace.

---

## Directory Structure

| Directory/Workspace          | Purpose                                                                 |
|-----------------------------|-------------------------------------------------------------------------|
| `terraform-cloud/bootstrap`  | Manual bootstrap: Vault auth + initial TFC workspaces                   |
| `terraform-cloud/namespace-root`             | TFC workspace for Vault root namespace resources                        |
| `terraform-cloud/namespace-vending`          | TFC workspace to create per-namespace workspaces                        |
| `terraform-cloud/namespace-*`                | TFC workspaces for each Vault namespace (apps, delivery, arquitectura…) |

---

## Usage Notes

- **All configuration is driven by your `terraform.tfvars` file.** Ensure it is complete and accurate before starting.
- **The `.env` file is required only for the manual bootstrap step.** It must be sourced in your shell before running `terraform apply` locally.
- **Subsequent runs and all other workspaces are managed automatically by Terraform Cloud.**