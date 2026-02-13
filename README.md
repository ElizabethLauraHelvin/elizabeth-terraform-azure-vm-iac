# Terraform Azure Virtual Machine (IaC)

## Overview

This repository contains a Terraform Infrastructure as Code (IaC) project used to provision and manage an Azure Linux Virtual Machine along with its required networking components. The project demonstrates how cloud infrastructure can be defined, versioned, updated, and destroyed using code instead of manual configuration through the Azure Portal.

The main goal of this project is to practice a proper DevOps workflow using Terraform and Git, including initialization, planning, applying changes, version control, and clean resource destruction.

## Project Objectives

- Provision an Azure Linux Virtual Machine using Terraform
- Manage infrastructure lifecycle (create, update, destroy) using code
- Apply best practices for version control with Git and GitHub
- Understand how Terraform state tracks real infrastructure
- Demonstrate small configuration changes and their impact

## Technologies Used

- Terraform
- Microsoft Azure
- AzureRM Terraform Provider
- Git & GitHub

## Project Structure

```
.├
|── .terraform/
│   ├── providers/
│   ├── modules/
│   └── terraform.tfstate.lock.inf
├── main.tf            # Main Terraform configuration file
├── variables.tf       # Input variables (if separated)
├── terraform.tfstate  # Terraform state file (NOT committed)
├── terraform.tfstate.backup
├── .gitignore         # Files and directories excluded from Git
└── README.md          # Project documentation
```

## Resources Managed

- Azure Resource Group
- Virtual Network (VNet)
- Subnet
- Network Interface
- Network Security Group
- Linux Virtual Machine (Ubuntu)

## Usage Instructions

### 1. Initialize Terraform

```bash
terraform init
```

This command initializes the working directory and downloads the required providers.

### 2. Validate Configuration

```bash
terraform validate
```

Ensures the Terraform configuration syntax is correct.

### 3. Review Execution Plan

```bash
terraform plan
```

Shows the changes Terraform will apply by comparing the current infrastructure state with the configuration files.

### 4. Apply Configuration

```bash
terraform apply
```

Creates or updates the Azure resources based on the configuration.

### 5. Destroy Resources

```bash
terraform destroy
```

Removes all resources managed by Terraform to avoid unnecessary cloud costs.

## Version Control Workflow

This project follows a simple Git workflow:

```
code → commit → push → review
```

- Sensitive files such as `terraform.tfstate` and credentials are excluded using `.gitignore`
- Clear and descriptive commit messages are used
- All infrastructure changes are tracked through Git history

## Notes on Security

- Terraform state files may contain sensitive information and should never be committed to public repositories
- Passwords and secrets are managed using Terraform variables
- Network access should be controlled using Network Security Groups

## Author

Elizabeth Laura Helvin

## Date

February 2026
