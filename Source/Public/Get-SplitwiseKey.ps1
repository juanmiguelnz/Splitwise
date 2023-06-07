function Get-SplitwiseKey {

#    Initialize-AWSConfig
    $Key    = Get-SECSecretValue -SecretId arn:aws:secretsmanager:us-east-1:451460415697:secret:Splitwise-CZz2cB | Select-Object -ExpandProperty SecretString
    $Token  = $Key | ConvertTo-SecureString -AsPlainText -Force

    Write-Output $Token
}