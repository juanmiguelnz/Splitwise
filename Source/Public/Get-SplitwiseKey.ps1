function Get-SplitwiseKey {

    $Key    = get-secSecretValue -SecretId "arn:aws:secretsmanager:us-east-1:451460415697:secret:Splitwise-CZz2cB" -Credential (Get-AWSCredential) | Select-Object -ExpandProperty SecretString
    $Token  = $Key | ConvertTo-SecureString -AsPlainText -Force

    Write-Output $Token
}