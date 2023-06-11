function Get-SplitwiseKey {

    $Token  = $Env:SPLITWISE_KEY | ConvertTo-SecureString -AsPlainText -Force

    Write-Output $Token
}