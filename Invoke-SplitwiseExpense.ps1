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
        $Token = $Splitwise | ConvertTo-SecureString -AsPlainText -Force
    }

    process{
        $Expense = Import-Csv $CsvFile

        $Expense | ForEach-Object {

            if ($_.Type -eq "D") {
                $Body = @{
                    cost            = $_.Amount
                    description     = $_.Details
                    group_id        = $GroupID
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
