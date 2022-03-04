## Azure resources deployed by Terraform  

- The creation of a resource group.
- The creation of a budget alert and alert group.
- The creation of a security policy. 
- The creation of a key vault and storage account. 
- The creation of a SQL server and SQL elastic pool.
- The provision of databases in the SQL elastic pool.

## Running locally 

1. Make appropriate changes to resource names and emails in terraform code (see comments in code).
2. Remove "-local" from variables.tfvars file name. 
3. Update variables.tfvars file with the required Azure information (Tenant ID, Service Principle secret and key etc). 
4. Update variables.tfvars file with a ENV_ID string var (e.g MY-DEV) this will ensure a new set of resources is created.
5. Update strong ADMIN_LOGIN and ADMIN_PASSWORD for SQL server provisioning in variables.tfvars.
6. Save the variables.tfvars file.
6. Run in the CLI in the terraform repo to validate connection with Azure and the Terraform. 

    ``` terraform plan -var-file=variables.tfvars ```

## Note - time based azure resource

This terraform deploys the smallest SQL server and elastic pool which uses 2 vcores, it has a time based cost of approx £250 pounds a month. 

Remember to terraform destroy to remove this repo after your experimentation. 

``` terraform destroy ```