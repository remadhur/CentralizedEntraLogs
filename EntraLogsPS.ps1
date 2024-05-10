# Please make sure to add the workspaceId in the code below i.e line 52
Connect-AzAccount -Tenant <Your Tennat ID> 
$accessToken = (Get-AzAccessToken -ResourceUrl "https://management.azure.com").Token
$apiEndpoint = "https://management.azure.com/providers/microsoft.aadiam/diagnosticSettings/Cyber-EnraLogs?api-version=2017-04-01-preview"
$body = @"
{
    "properties": {
        "logs": [
            {
                "category": "AuditLogs",
                "enabled": true,
                "retentionPolicy": {
                    "days": 0,
                    "enabled": false
                }
            },
            {
                "category": "ProvisioningLogs",
                "enabled": true,
                "retentionPolicy": {
                    "days": 0,
                    "enabled": false
                }
            },
            {
                "category": "NonInteractiveUserSignInLogs",
                "enabled": true,
                "retentionPolicy": {
                    "days": 0,
                    "enabled": false
                }
            },
            {
                "category": "RiskyUsers",
                "enabled": true,
                "retentionPolicy": {
                    "days": 0,
                    "enabled": false
                }
            },
            {
                "category": "SignInLogs",
                "enabled": true,
                "retentionPolicy": {
                    "days": 0,
                    "enabled": false
                }
            }
            
        ],
        "metrics": [],
        "workspaceId": "..........."
    }
}
"@
# Set the headers
$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-Type" = "application/json"
}

# Make the PUT request to create the diagnostic setting
$response = Invoke-RestMethod -Uri $apiEndpoint -Headers $headers -Method Put -Body $body

# Output the result
Write-Output "Diagnostic setting created successfully."
