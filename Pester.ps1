$PesterConfig                           = New-PesterConfiguration
$PesterConfig.TestResult.OutputFormat   = "NUnitXml"
$PesterConfig.TestResult.OutputPath     = "Tests/Unit.Test.xml"
$PesterConfig.TestResult.Enabled        = $True
Invoke-Pester -Configuration $PesterConfig