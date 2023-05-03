function Invoke-SplitwiseExpense {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_})]
        $CsvFile,

        [Parameter(Mandatory=$true)]
        $GroupID
    )

    begin{
        $Token = $Env:Splitwise | ConvertTo-SecureString -AsPlainText -Force
    }

    process{

        Import-Csv $CsvFile | ForEach-Object {
            if (($_.Type -eq "D") -and
                ($_.Details -notlike "Iag*") -and
                ($_.Details -notlike "Myrepublic*") -and
                ($_.Details -notlike "Countdown*") -and
                ($_.Details -notlike "Pak*") -and
                ($_.Details -notlike "Skinny*")) {

                    $TransactionDate = Get-Date -Date $_.TransactionDate -Format "o"

                    $Body = @{
                        group_id        = $GroupID
                        description     = $_.Details
                        cost            = $_.Amount
                        date            = $TransactionDate
                        split_equally   = $true
                    }

                    $JsonBody = $Body | ConvertTo-Json

                    $Params = @{
                        Method          = "POST"
                        Uri             = "https://secure.splitwise.com/api/v3.0/create_expense"
                        Body            = $JsonBody
                        ContentType     = "application/json"
                        Authentication  = "Bearer"
                        Token           = $Token
                    }
                    $Request = Invoke-RestMethod @Params

                    Write-Output $Request.expenses
            }
        }
    }
    end{}
}
