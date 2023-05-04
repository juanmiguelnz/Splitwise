function Add-SplitwiseUserToGroup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        $GroupID,
        [Parameter(Mandatory=$true)]
        $UserID
    )

    $Token = Get-SplitwiseKey

    $Body = @{
        group_id    = $GroupID
        user_id     = $UserID
    }

    $JsonBOdy = $Body | ConvertTo-Json

    $Params = @{
        Method          = "GET"
        Uri             = "https://secure.splitwise.com/api/v3.0/add_user_to_group"
        Body            = $JsonBOdy
        ContentType     = "application/json"
        Authentication  = "Bearer"
        Token           = $Token
    }

    $Request = Invoke-RestMethod @Params

    if ($Request.success -eq "True") {
        Write-Output $Request.user
    } else {
        Write-Warning -Message "User is already in the group."
    }
}