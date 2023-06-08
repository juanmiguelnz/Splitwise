function Initialize-AWSAssumeRole {
    param (
        [string]$RoleArn,
        [string]$RoleSessionName
    )

    Import-Module AWSPowerShell.NetCore -Force
    Write-Output (Use-STSRole -RoleArn $RoleArn -RoleSessionName $RoleSessionName).Credentials
}