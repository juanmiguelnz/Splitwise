function Get-SplitwiseKey {

    Get-AWSCredential -ListProfileDetail
    Set-AWSCredential -ProfileName default
    $Creds  = Initialize-AWSAssumeRole -RoleArn "arn:aws:iam::451460415697:role/Role-SecretManager-ProdAccount-Access" -RoleSessionName "CodeBuildSession"
    $Key    = Get-SECSecretValue -SecretId "arn:aws:secretsmanager:us-east-1:451460415697:secret:Splitwise-CZz2cB" -Credential $Creds | Select-Object -ExpandProperty SecretString
    $Token  = $Key | ConvertTo-SecureString -AsPlainText -Force

    Write-Output $Token
}