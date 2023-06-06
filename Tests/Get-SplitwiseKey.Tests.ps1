BeforeAll {
    Import-Module ./Output/Splitwise/Splitwise.psm1 -Verbose
}

Describe Get-SplitwiseKey {
    Context "Get Splitwise Key" {
        BeforeAll {
            $SwKey = Get-SplitwiseKey
        }

        It "Returns current user" {
            
            $SwKey | Should -Be "System.Security.SecureString"
        }
    }
}