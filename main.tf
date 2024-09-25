
resource "azurerm_resource_group" "rg" {
   name     = var.resource_group_name
  location = var.location
  tags     = var.resource_group_tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_cidrs
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    "Environment" = "Production",
    "Project"     = "AzureNetwork"
  }
}


resource "azurerm_subnet" "subnet" {
  count               = length(var.subnet_cidrs)
  name                = var.subnet_names[count.index]
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes    = [var.subnet_cidrs[count.index]]
  service_endpoints   = ["Microsoft.Storage", "Microsoft.KeyVault"]  # <--- Add other services as needed

  # Ensure subnets are created after the VNet
  depends_on = [
    var.vnet_cidrs,
    var.resource_group_name
  ]
}

resource "azurerm_network_security_group" "aac_nsg" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                        = "allow_ssh"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = var.on_prem_cidr # <--- Recommended to allow only trusted CIDR i.e. Alteryx Designer Cloud CIDR or Your On-Prem CIDR in variables.tf
    destination_address_prefix  = "*"  # Fixing the prefix issue
  }

  security_rule {
    name                        = "allow_http"
    priority                    = 200
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = var.aac_cidr # <--- Recommended to allow only trusted CIDR i.e. Alteryx Designer Cloud CIDR in variables.tf
    destination_address_prefix  = "*"  # Fixing the prefix issue
  }

  security_rule {
    name                        = "allow_https"
    priority                    = 300
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = var.aac_cidr # <--- Recommended to allow only trusted CIDR i.e. Alteryx Designer Cloud CIDR in variables.tf
    destination_address_prefix  = "*"  # Added HTTPS rule and fixed the prefix issue
  }

  depends_on = [
    var.subnet_cidrs
  ]
}