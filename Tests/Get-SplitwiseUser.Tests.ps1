BeforeAll {
    Import-Module ./Output/Splitwise/Splitwise.psm1
}

BeforeAll {
    Import-Module ./Output/Splitwise/Splitwise.psm1 -Verbose
}

Describe Get-SplitwiseUser {
    Context "Get Splitwise User" {
        BeforeAll {
            $SwUser = Get-SplitwiseUser
        }

        It "Returns current user" {
            
            $SwUser | Should -Not -BeNullOrEmpty
            $SwUser.first_name | Should -Be "Miguel"
            $SwUser.registration_status | Should -Be "confirmed"
        }
    }
}