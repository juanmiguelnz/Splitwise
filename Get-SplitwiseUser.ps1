function Get-SplitwiseUser {
    $Token  = $Env:Splitwise | ConvertTo-SecureString -AsPlainText -Force

    $Params = @{
        Method          = "GET"
        Uri             = "https://secure.splitwise.com/api/v3.0/get_current_user"
        Authentication  = "Bearer"
        Token           = $Token
    }
    $Request = Invoke-RestMethod @Params -Verbose

    Write-Output $Request.user
}