# Please use terraform v12.29 to start with for all labs, I will use terraform v13 and v14 from lab 7.5 onwards
terraform {
  backend "azurerm" {
resource_group_name  = "Terra-rg"
storage_account_name = "remotesa10"
container_name       = "lab10"
key                  = "tfstate"
}
 }