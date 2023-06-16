if (Test-Path -Path Env:/AWS_EXECUTION_ENV) {
    $Params = @{
        SourcePath                  = "Source\Splitwise.psd1"
        Version                     = "1.1.$($Env:CODEBUILD_BUILD_NUMBER)"
        UnversionedOutputDirectory  = $true
    }
} else {
    $Params = @{
        SourcePath                  = "Source\Splitwise.psd1"
        Version                     = "0.0.1"
        UnversionedOutputDirectory  = $true
    }
}
Build-Module @Params