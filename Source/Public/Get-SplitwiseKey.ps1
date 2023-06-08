function Get-SplitwiseKey {

    Get-AWSCredential -ListProfileDetail

    $Creds = (Use-STSRole -RoleArn "arn:aws:iam::869073653340:role/service-role/AwsDevOpsCodeBuildServiceRole" -RoleSessionName "HelloWorld").Credentials
    $Key    = get-secSecretValue -SecretId "arn:aws:secretsmanager:us-east-1:451460415697:secret:Splitwise-CZz2cB" -Credential $Creds | Select-Object -ExpandProperty SecretString
    $Token  = $Key | ConvertTo-SecureString -AsPlainText -Force

    Write-Output $Token
}