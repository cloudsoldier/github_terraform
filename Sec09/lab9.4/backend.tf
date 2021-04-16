 terraform {
  backend "azurerm" {
resource_group_name  = "Terra-rg"
storage_account_name = "remotesa10"
container_name       = "lab9-4"
key                  = "Lab9.4.tfstate"
}
 }

## kash code #