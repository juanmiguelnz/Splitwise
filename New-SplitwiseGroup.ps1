function New-SplitwiseGroup {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name,

        [string]$Member
    )

    Initialize-AWSConfig
    $Key    = Get-SECSecretValue -SecretId arn:aws:secretsmanager:us-east-1:451460415697:secret:Splitwise-CZz2cB | Select-Object -ExpandProperty SecretString
    $Token  = $Key | ConvertTo-SecureString -AsPlainText -Force

    $Body = @{
        name            = $Name
        users__0__email = $Member
    }

    $JsonBOdy = $Body | ConvertTo-Json

    $Params = @{
        Method          = "POST"
        Uri             = "https://secure.splitwise.com/api/v3.0/create_group"
        Body            = $JsonBOdy
        ContentType     = "application/json"
        Authentication  = "Bearer"
        Token           = $Token
    }

    $Request = Invoke-RestMethod @Params

    Write-Output $Request.group
}