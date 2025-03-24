#!/bin/bash

get_kv_availability() {
  local subscription_id="$AZURE_SUBSCRIPTION_ID"
  local resource_group="$AZURE_RESOURCE_GROUP"
  
  local json_output='{"metrics":['
  local first=true

  for kv in $(az keyvault list --subscription "$subscription_id" --query "[].name" -o tsv); do
    echo "Checking availability for Key Vault: $kv..."
    
    local availability
    availability=$(az monitor metrics list \
      --resource "/subscriptions/$subscription_id/resourceGroups/$resource_group/providers/Microsoft.KeyVault/vaults/$kv" \
      --metric Availability \
      --aggregation average \
      --interval PT1H \
      --query "value[0].timeseries[0].data[-1].average" \
      --output tsv)
    
    # Default to N/A if no data is returned
    availability=${availability:-"N/A"}

    # Append to JSON array
    if [ "$first" = true ]; then
      first=false
    else
      json_output+=','
    fi
    json_output+="{\"kv_name\":\"$kv\",\"percentage\":\"$availability\"}"
  done

  json_output+=']}'
  echo "$json_output"
}

# Call the function
get_kv_availability