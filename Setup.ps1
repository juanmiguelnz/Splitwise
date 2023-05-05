Install-Module -Name PSScriptAnalyzer,ModuleBuilder,Pester,AWS.Tools.Installer -Force
Install-AWSToolsModule AWS.Tools.Common,AWS.Tools.IdentityManagement,AWS.Tools.SecretsManager -Force

#Set-AWSCredential -AccessKey "" -SecretKey "" -StoreAs "PowerShell"
Set-AWSCredential -ProfileName $ProfileName
Set-DefaultAWSRegion -Region $Region