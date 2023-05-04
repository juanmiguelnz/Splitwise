function New-SplitwiseGroup {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name,

        [string]$Member
    )

    $Token = Get-SplitwiseKey

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