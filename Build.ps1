$Params = @{
    SourcePath                  = "Source\Splitwise.psd1"
    Version                     = "1.0.$($Env:CODEBUILD_BUILD_NUMBER)"
    UnversionedOutputDirectory  = $true
}

Build-Module @Params -Passthru -Verbose