
***

# Multi-Module Terraform Project

This repository serves as a blueprint for managing infrastructure using a **Modular Terraform Architecture**. By separating resource definitions from environment-specific configurations, this project ensures high reusability, consistency, and a clean separation of concerns.



## 🏗 Project Architecture

The project follows a "Live vs. Modules" structure:

* **Modules:** Defined once in the `/modules` folder. They act as templates (e.g., a standard VPC, an EC2 instance with specific security settings).
* **Environments:** Located in the `/environments` (or `/live`) folder. These call the modules and pass in specific variables for `dev`, `staging`, or `prod`.



## 📂 Directory Layout

```text
.
├── modules/
│   ├── network/            # VPC, Subnets, Internet Gateway
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/            # EC2 Instances, Auto Scaling
│   │   ├── main.tf
│   │   └── variables.tf
│   └── database/           # RDS or DynamoDB
├── environments/
│   ├── dev/                # Development Environment
│   │   ├── main.tf         # Module calls
│   │   └── terraform.tfvars
│   └── prod/               # Production Environment
│       ├── main.tf
│       └── terraform.tfvars
├── main.tf                 # Global configuration (optional)
└── variables.tf            # Global variables
```

## 🚀 Getting Started

### 1. Prerequisites
* [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) installed.
* Cloud provider credentials (AWS/Azure/GCP) configured locally.

### 2. Initialization
Navigate to the specific environment you wish to deploy (e.g., `dev`) and initialize the backend and modules:
```bash
cd environments/dev
terraform init
```

### 3. Deployment Flow
Always run a plan first to verify what resources will be created, modified, or destroyed:
```bash
terraform plan
```
If the plan looks correct, apply the changes:
```bash
terraform apply
```

## 🛠 Features
* **Reusability:** Write code once in `modules/` and deploy it across N environments.
* **Isolation:** Changes in the `dev` environment folder do not affect `prod` state files.
* **Standardization:** Ensure all environments use the same security group rules and tagging standards.

## 📝 Best Practices
* **Remote State:** Use an S3/GCS backend with State Locking (DynamoDB) to prevent state corruption.
* **Versioning:** Source modules using specific versions or git tags.
* **Formatting:** Always run `terraform fmt` before committing code.

---
**Maintained by:** [Jonas Kwame Nyador]
