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
        $Token = Get-SplitwiseKey
    }

    process{

        $Csv            = Import-Csv $CsvFile
        $CsvProperties  = $Csv | Get-Member | Select-Object -ExpandProperty Name

        $Csv | ForEach-Object {

            $Bank = if ($CsvProperties -contains "ProcessedDate") {
                ([PSCustomObject]@{
                    Name            = "ANZ"
                    Details         = $_.Details
                    TransactionDate = (Get-Date -Date $_.TransactionDate -Format "o")
                })
            } else {
                ([PSCustomObject]@{
                    Name            = "AMEX"
                    Details         = $_.Description
                    TransactionDate = (Get-Date -Date $_.Date -Format "o")
                })
            }

            if ($Bank.Details -like "*payment*") {

                Write-Output $Bank.Details

            } else {
                if (($Bank.Details -notlike "Iag*") -and
                    ($Bank.Details -notlike "Myrepublic*") -and
                    ($Bank.Details -notlike "Countdown*") -and
                    ($Bank.Details -notlike "Pak*") -and
                    ($Bank.Details -notlike "Skinny*")) {

                        $Body = @{
                            group_id        = $GroupID
                            description     = $Bank.Details
                            cost            = $_.Amount
                            date            = $Bank.TransactionDate
                            split_equally   = $True
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
                        Write-Output $Request.expenses -Verbose
                }
            }
        }
    }
    end{}
}
