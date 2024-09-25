variable "subscription_id" {
  description = "Azure Subscription ID"
  default = "00000000-0000-0000-0000-000000000000"  # <-- Subnet you want to deploy PDH
}

variable "service_principal_id" {
  description = ""
  default =  "11111111-1111-1111-1111-111111111111"  # <-- Application ID of Service Principal crated in Enterprise Applications
}

variable "service_principal_secrect" {
  description = ""
  default = "<client-secret>" #<-- Client Value from App Registration
}

variable "tenant_id" {
  description = ""
  default = "22222222-2222-2222-2222-222222222222" #<-- Your Tenant ID
}

variable "dataplane_prefix" {
  description = "Prefix for resources"
  default = "acc-dataplane"
}

variable "resource_group_name" {
  description = "Name of PDH resource group"
  default = "aac_resource_group"
}

variable "resource_group_tags" {
  description = "Tags to be applied to the Resource Groups"
  type        = map(string)
  default     = {
    "AACResource" = "aac"
  }
}

variable "location" {
  description = "Azure Region for Resource Groups"
  default     = "East US"
}
variable "vnet_name" {
  description = "Name of the Virtual Network"
  default     = "aac-vnet"
}

# Change these CIDR ranges to suit your environment
variable "vnet_cidrs" {
  description = "List of CIDR blocks for VNET"
  type = list(string)
  default = [
    "10.64.0.0/18", # First CIDR 16,384 Addresses
    "10.10.0.0/23"  # Second CIDR 512 Addresses
]
}

# Change these CIDR ranges to suit your environment
variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
  default     = [
    "10.64.0.0/19",   # AKS cluster subnet 8,192 Addresses
#    "10.64.32.0/19",  # SPARE subnet (Blue / Green) Optional but can add later if needed
    "10.10.0.0/24",   # Option subnet (Cloud Execution for Desktop)
    "10.10.1.0/25",   # Private subnet for specific use
    "10.10.1.128/25"   # Public subnet
  ]
}

variable "subnet_names" {
  description = "List of names for the subnets"
  type        = list(string)
  default     = [
    "aac_aks_node",
#    "aac_spare_subnet",
    "aac_option",
    "acc_private",
    "aac_public"
  ]
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  default     = "aac_nsg"
}

variable "on_prem_cidr" {
  description = "Add your company CIDR"
  default = "0.0.0.0/0"
}

variable "aac_cidr" {
  description = "Add Alteryx Designer Cloud CIDR"
  default = "0.0.0.0/0"
}