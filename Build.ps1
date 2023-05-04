$Params = @{
    SourcePath                  = "Source\Splitwise.psd1"
    Version                     = "0.0.1"
    UnversionedOutputDirectory  = $true
}

Build-Module @Params -Passthru -Verbose