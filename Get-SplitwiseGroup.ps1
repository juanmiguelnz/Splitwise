function Get-SplitwiseGroup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [Alias("Name")]
        [string]$GroupName
    )

    $Token  = $Splitwise | ConvertTo-SecureString -AsPlainText -Force

    $Params = @{
        Method          = "GET"
        Uri             = "https://secure.splitwise.com/api/v3.0/get_groups"
        Authentication  = "Bearer"
        Token           = $Token
    }

    $Request = Invoke-RestMethod @Params
    $Groups = $Request | Select-Object -ExpandProperty groups

    Write-Output $Groups | Where-Object -Property Name -eq $GroupName
}
