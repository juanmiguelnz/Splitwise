function Get-SplitwiseUser {

    Initialize-AWSConfig
    $Key    = Get-SECSecretValue -SecretId arn:aws:secretsmanager:us-east-1:451460415697:secret:Splitwise-CZz2cB | Select-Object -ExpandProperty SecretString
    $Token  = $Key | ConvertTo-SecureString -AsPlainText -Force

    $Params = @{
        Method          = "GET"
        Uri             = "https://secure.splitwise.com/api/v3.0/get_current_user"
        Authentication  = "Bearer"
        Token           = $Token
    }
    $Request = Invoke-RestMethod @Params

    Write-Output $Request.user
}