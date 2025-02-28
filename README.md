# Terraform Workspaces

Terraform workspaces allow you to manage multiple environments (such as `dev`, `uat`, and `prod`) using the same Terraform configuration. This helps maintain separate state files for different environments without creating duplicate configuration files.

## Default Workspace
Terraform provides a built-in workspace named `default`. If no workspace is specified, Terraform operates in this default workspace.

## Common Use Case
You can use workspaces to manage different AWS environments:

- `dev` – Development environment  
- `uat` – User Acceptance Testing  
- `prod` – Production environment  

## Terraform Workspace Commands

| Command | Description |
|---------|------------|
| `terraform workspace list` | Lists all available workspaces |
| `terraform workspace show` | Displays the current active workspace |
| `terraform workspace new <workspace_name>` | Creates a new workspace |
| `terraform workspace select <workspace_name>` | Switches to an existing workspace |
| `terraform workspace delete <workspace_name>` | Deletes a specified workspace (except `default`) |

## Example Workflow

```sh
# List available workspaces
terraform workspace list  

# Create a new workspace
terraform workspace new dev  

# Switch to a workspace
terraform workspace select dev  

# Verify the current workspace
terraform workspace show  
