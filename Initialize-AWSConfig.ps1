function Initialize-AWSConfig {
    param (
        [string]$ProfileName = "PowerShell",
        [string]$Region = "us-east-1"
    )

    Set-AWSCredential -ProfileName $ProfileName
    Set-DefaultAWSRegion -Region $Region
}