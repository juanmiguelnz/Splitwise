BeforeAll {
    Import-Module ./Output/Splitwise/Splitwise.psm1 -Verbose
}

Describe Get-SplitwiseUser {
    Context "Get Splitwise User" {
        BeforeAll {
            $SwKey = Get-SplitwiseKey
        }

        It "Returns current user" {
            
            $SwKey | Should -Be "System.Security.SecureString"
        }
    }
}