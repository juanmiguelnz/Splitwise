#Install-Module -Name PSScriptAnalyzer, ModuleBuilder, Pester, AWS.Tools.Installer -Force
#Install-AWSToolsModule AWS.Tools.Common,AWS.Tools.IdentityManagement,AWS.Tools.SecretsManager, AWS.Tools.SecurityToken -Force

#Set-AWSCredential -AccessKey $Env:ACCESS_KEY -SecretKey $Env:SECRET_KEY -StoreAs "PowerShell" -Verbose
#Get-AWSCredential -ListProfileDetail

Install-Module AWSPowerShell.NetCore -Force
Import-Module AWSPowerShell.NetCore -Force

$Sts = (Use-STSRole -RoleArn "arn:aws:iam::451460415697:role/Role-SecretManager-ProdAccount-Access" -RoleSessionName "CodeBuildRoleSession").Credentials
Set-AWSCredential -AccessKey $Sts.AccessKeyId -Secret $Sts.SecretAccessKey -StoreAs CodeBuildProfile