Install-Module -Name PSScriptAnalyzer, ModuleBuilder, Pester, AWS.Tools.Installer -Force
Install-AWSToolsModule AWS.Tools.Common,AWS.Tools.IdentityManagement,AWS.Tools.SecretsManager -Force

#Set-AWSCredential -AccessKey $Env:ACCESS_KEY -SecretKey $Env:SECRET_KEY -StoreAs "PowerShell"
