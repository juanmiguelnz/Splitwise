BeforeAll {
    Import-Module ./Output/Splitwise/Splitwise.psm1 -Verbose
    Import-Module AWSPowerShell.NetCore -Force -Verbose
}

Describe Get-SplitwiseKey {
    Context "Get Splitwise Key" {
        BeforeAll {
            $SwKey = Get-SplitwiseKey
        }

        It "Returns SecureString" {
            
            $SwKey | Should -Be "System.Security.SecureString"
        }
    }
}