keyVaultName='your-unique-vault-name'
resourceGroupName='your-resource-group-name'
location='westeurope'
userPrincipalName='your-email-address-associated-with-your-subscription'

# Creamos un grupo de recursos
az group create --name $resourceGroupName --location $location

# Creamos un Key Vault
az keyvault create \
  --name $keyVaultName \
  --resource-group $resourceGroupName \
  --location $location \
  --enabled-for-template-deployment true
az keyvault set-policy --upn $userPrincipalName --name $keyVaultName --secret-permissions set delete get list

# Creamos un secreto con nombre: vmAdminPassword
password=$(openssl rand -base64 32)
echo $password
az keyvault secret set --vault-name $keyVaultName --name 'vmAdminPassword' --value $password