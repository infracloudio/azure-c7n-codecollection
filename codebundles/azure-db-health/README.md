# Azure Database Health
This codebundle runs a suite of metrics checks for Database in Azure. It identifies:
- Databases that are publicly accessible
- Databases without replication configured  
- Databases without high availability configuration
- Databases with high CPU usage
- Databases with high memory usage
- Redis caches with high cache miss rate

## Configuration

The TaskSet requires initialization to import necessary secrets, services, and user variables. The following variables should be set:

- `AZ_USERNAME`: Service principal's client ID
- `AZ_SECRET_VALUE`: The credential secret value from the app registration
- `AZ_TENANT`: The Azure tenancy ID
- `AZ_SUBSCRIPTION`: The Azure subscription ID

## Testing 
See the .test directory for infrastructure test code. 

## Notes

This codebundle assumes the service principal authentication flow