# Private Data Handling Terraform Port for Azure

## Attention:  
This is base code set to assist with automating Private Data Handling for Alteryx Analytics Cloud Platform in an Azure environment, there is absolutely no support for this code is being offered as a staring point only and should be considered open source and freeware, modify or enhance for your environment at will. **Use at your own risk!**  

## THERE IS ABSOLUTLEY NO SUPPORT FOR THIS CODE BASE.  

#### Recommendation:
Use this code base on a isolated environment, do not execute on Production, it is specific to Private Data Handling for Alteryx Designer Cloud in Azure. 

### Features:
Base setup of VPC,Subnets,Resource Groups, and NSG required for PDH

### How to use terraform:
https://developer.hashicorp.com/terraform/tutorials/automation/automate-terraform

## Prerequisites:
- Azure Tenant
- Azure Subscription
- Contributor Access to Subscription
- Service Principal (Enterprise App)
  - Grant Contributor access to Service Principal Subscription
  - App Registration - Create Client ID and Secret
- Knowledge of Azure VNETs and Subnetting
- Knowledge of Terraform and how to execute init, validate, plan, apply

## Modify the following files Azure deployment

provider.tf 
- subscription_id
- tenant_id
- client_id (Application ID of Service Principal)
- client_secret (Secret from App Registration of Service Principal)

backend.tf - This is where you would add a storage account to store your terraform state file

variables.tf - variables to modify

- subscription_id  (Your Subscription)
- tenant_id (Your Tenant)
- client_id (Service Principal Applicaton ID)
- client_secret (App Registration Value from Service Principal)
- location (East US, WEST US, etc...)
- vnet_cidrs (If the given CDIR overlaps with your network CIDRs)
- subnet_cidrs (If you change the VNET cidr you will need to change subnet CIDRs)

## Credentials and identifiers

The subscription, tenant and application ids in `variables.tf` are placeholders, and the client secret must never be set in a file. Pass it at run time, for example `TF_VAR_service_principal_secrect`, or use `az login`. State files are ignored by `.gitignore` and must never be committed.
