
# Please use terraform v12.29 to start with for all labs, I will use terraform v13 and v14 from lab 7.5 onwards

resource "azurerm_resource_group" "be-rg" {
  name     = var.be-rg-name
  location = var.location-name
}
resource "azurerm_virtual_network" "be-rg" {
  name                = var.web-vnet-name
  address_space       = ["10.0.2.0/23"]
  location            = azurerm_resource_group.be-rg.location
  resource_group_name = azurerm_resource_group.be-rg.name
}

module "web-vm" {
  source = "../../module/compute"
  vm-name = var.web-vm-name
  subnet_id = azurerm_subnet.be-rg.id
  location = azurerm_resource_group.be-rg.location
  rg = azurerm_resource_group.be-rg.name
  admin_password = var.admin_password
}

resource "azurerm_subnet" "be-rg" {
  name                 = var.web-sub-name
  resource_group_name  = azurerm_resource_group.be-rg.name
  virtual_network_name = azurerm_virtual_network.be-rg.name
  address_prefixes     = ["10.0.2.0/24"]
}



resource "azurerm_network_security_rule" "be-rg" {
  name                        = "web"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "${module.web-vm.vm_private_ip}/32"
  resource_group_name         = azurerm_resource_group.be-rg.name
  network_security_group_name = module.web-vm.nsg_name
}

resource "azurerm_network_interface_security_group_association" "be-rg" {
  network_interface_id      = module.web-vm.nic_id
  network_security_group_id = module.web-vm.nsg_id
}



resource "azurerm_virtual_machine_extension" "be-rg" {
  name                 = "iis-extension"
  virtual_machine_id   = module.web-vm.vm_id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings             = <<SETTINGS
    {
        "commandToExecute": "powershell Install-WindowsFeature -name Web-Server -IncludeManagementTools;"
    }
SETTINGS
}