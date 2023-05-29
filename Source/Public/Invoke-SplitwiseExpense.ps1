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

            $BankObj = if ($CsvProperties -contains "ProcessedDate") {
                [PSCustomObject]@{
                    Name            = "ANZ"
                    Details         = $_.Details
                    TransactionDate = (Get-Date -Date $_.TransactionDate -Format "o")
                }
            } else {
                [PSCustomObject]@{
                    Name            = "AMEX"
                    Details         = $_.Description
                    TransactionDate = (Get-Date -Date $_.Date -Format "o")
                }
            }

            if ($BankObj.Details -like "*payment*") {
                Write-Output $BankObj.Details

            } else {
                if (($BankObj.Details -notlike "Iag*") -and
                    ($BankObj.Details -notlike "Myrepublic*") -and
                    ($BankObj.Details -notlike "Countdown*") -and
                    ($BankObj.Details -notlike "Pak*") -and
                    ($BankObj.Details -notlike "Skinny*")) {

                        $Body = @{
                            group_id        = $GroupID
                            description     = $BankObj.Details
                            cost            = $_.Amount
                            date            = $BankObj.TransactionDate
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
