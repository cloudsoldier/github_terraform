 terraform {
  backend "azurerm" {
resource_group_name  = "Terra-rg"
storage_account_name = "remotesa10"
container_name       = "lab9"
key                  = "Lab9.1.tfstate"
}
 }

#  {
#   "appId": "550f7397-f4ea-48ac-9889-07455ef8fb53",
#   "displayName": "azure-cli-2021-04-10-16-08-09",
#   "name": "http://azure-cli-2021-04-10-16-08-09",
#   "password": "C~G0tOpezX~aQMwUl3z8XZVpfpqsk~q0gX",
#   "tenant": "9090e49c-38c7-4fe4-a00c-01b22e47ae0c"
# }
# export ARM_CLIENT_ID="550f7397-f4ea-48ac-9889-07455ef8fb53"
# export  ARM_CLIENT_SECRET="C~G0tOpezX~aQMwUl3z8XZVpfpqsk~q0gX"
# export ARM_SUBSCRIPTION_ID="317af27c-bb9b-43c5-ad52-ae1d11ed72c0"
# export ARM_TENANT_ID="9090e49c-38c7-4fe4-a00c-01b22e47ae0c"
