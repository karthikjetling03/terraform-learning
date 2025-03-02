# Terraform Complete Guide

Welcome to my **Terraform learning repository!** 🚀 This document serves as a reference guide, covering all Terraform concepts from **scratch to an intermediate level** with examples.

---

## 📌 **What is Terraform?**
Terraform is an **Infrastructure as Code (IaC)** tool that allows you to define, provision, and manage cloud infrastructure using a declarative configuration language called **HCL (HashiCorp Configuration Language).**

- **Declarative:** You define the desired state, and Terraform takes care of making it happen.
- **Multi-Cloud:** Supports AWS, Azure, GCP, and other providers.
- **State Management:** Uses state files to track infrastructure.
- **Modules & Reusability:** Helps manage complex configurations efficiently.

---

## 🛠 **1. Installing Terraform**

### **🔹 Steps to Install:**
1. Download Terraform: [Terraform Downloads](https://developer.hashicorp.com/terraform/downloads)
2. Extract and move the binary to a location in your system's `PATH`.
3. Verify installation:
   ```sh
   terraform version
   ```

---

## 🏗 **2. Terraform Basics**

### **🔹 Initializing a Terraform Project**
```sh
touch main.tf   # Create a main configuration file
terraform init  # Initialize the working directory
```

### **🔹 Providers**
Providers are plugins that interact with cloud platforms (AWS, Azure, etc.).

#### Example: AWS Provider
```hcl
provider "aws" {
  region = "us-east-1"
}
```

### **🔹 Resources**
Resources are the actual infrastructure components.

#### Example: Creating an EC2 Instance
```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}
```

---

## 🎛 **3. Terraform Commands**

| Command               | Description                                      |
|----------------------|--------------------------------------------------|
| `terraform init`     | Initializes the Terraform project.              |
| `terraform plan`     | Shows what Terraform will change before applying. |
| `terraform apply`    | Creates or updates resources.                    |
| `terraform destroy`  | Deletes all resources.                           |
| `terraform fmt`      | Formats the Terraform files.                     |
| `terraform validate` | Validates the configuration files.               |

---

## 🔢 **4. Variables in Terraform**
Variables make Terraform configurations **dynamic** and reusable.

### **🔹 Defining Variables**
```hcl
variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}
```

### **🔹 Using Variables**
```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = var.instance_type
}
```

---

## 🏗 **5. Terraform State**
Terraform maintains a **state file** (`terraform.tfstate`) to track resources.

### **🔹 Remote State Storage (AWS S3 Example)**
```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

---

## 📦 **6. Terraform Modules**
Modules help **reuse** and **organize** Terraform configurations.

### **🔹 Creating a Module**
1. Create a directory `modules/ec2/`
2. Inside, create `main.tf`, `variables.tf`, and `outputs.tf`

#### **main.tf (Module Definition)**
```hcl
resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
}
```

#### **variables.tf (Module Variables)**
```hcl
variable "ami" {}
variable "instance_type" {}
```

#### **outputs.tf (Module Output)**
```hcl
output "instance_id" {
  value = aws_instance.example.id
}
```

### **🔹 Using the Module in `main.tf`**
```hcl
module "ec2_instance" {
  source        = "./modules/ec2"
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}
```

---

## 🚀 **7. Terraform Best Practices**
✅ Use **remote state storage** (S3, Terraform Cloud) instead of local state.  
✅ Organize code using **modules** for better reusability.  
✅ Follow **Git version control** for tracking changes.  
✅ Implement **`terraform fmt`** to format code properly.  
✅ Use **variables** instead of hardcoding values.  

---

## 📚 **8. Resources & References**
- [Terraform Official Docs](https://developer.hashicorp.com/terraform/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [AWS Terraform Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)